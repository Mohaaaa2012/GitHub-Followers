//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Apple on 9/9/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit


class FollowersListVC: UIViewController {
    
    enum Section { case main }
    
    var userName: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var pageNumber = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    var collectionView: UICollectionView!
    //UICollectionViewDiffableDataSource<Section of the view,items in the view>
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
    
    
    init(userName: String) {
        super.init(nibName: nil, bundle: nil)
        self.userName = userName
        title = userName
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: userName, page: pageNumber)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.isNavigationBarHidden = false
        // we use setNavigationBarHidden because in transition between two screens the bar we want not to be disappeared
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeCoulmnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    func getFollowers(username: String , page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch(result){
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Bad stuff happend", message: error.rawValue, buttonTitle: "Ok")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    
    func updateUI(with followers: [Follower]) {
        
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😀"
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        
        self.updateData(for: self.followers)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(for followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        // you should call apply function from main thread
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            
            guard let self = self else { return }
            
            guard let error = error else {
                self.presentGFAlertOnMainThread(alertTitle: "Success!", message: "You've successfully favorited this user🎉", buttonTitle: "Horray!")
                return
            }
            self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // The position of the content view within the scroll view
        // is called the content offset and is represented by
        // the contentOffset property, a CGPoint value.
        let offsetY = scrollView.contentOffset.y
        // contentHeigh : the height of the whole list of followers
        let contentHeight = scrollView.contentSize.height
        // height of the screen
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            pageNumber += 1
            getFollowers(username: userName, page: pageNumber)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.row]
        
        let destVC = UserinfoVC()
        destVC.delegate = self
        destVC.userName = follower.login
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


extension FollowersListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else {
            
            filteredFollowers.removeAll()
            updateData(for: followers)
            isSearching = false
            return
        }
        isSearching = true
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(for: filteredFollowers)
    }
}


extension FollowersListVC: UserinfoVCDelegate {
    
    func didRequestFollowers(for userName: String) {
        self.userName = userName
        title = userName
        // reset the page to the first one
        pageNumber = 1
        
        // reset the two arrays
        followers.removeAll()
        filteredFollowers.removeAll()
        // set the collection view up to the top
//        collectionView.setContentOffset(.zero, animated: true)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: userName, page: pageNumber)
    }
}
