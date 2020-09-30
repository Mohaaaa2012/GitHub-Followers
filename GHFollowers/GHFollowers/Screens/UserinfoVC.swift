//
//  UserinfoVC.swift
//  GHFollowers
//
//  Created by Apple on 9/13/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

protocol UserinfoVCDelegate: class {
    func didRequestFollowers(for userName: String)
}

class UserinfoVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dataLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var userName: String!
    weak var delegate: UserinfoVCDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollview()
        layoutUI()
        getUserInfo()
    }
    
    
    func configureViewController() {
        
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func configureScrollview() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        
        ])
        
    }
    
    func getUserInfo() {
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self]result in
            guard let self = self else { return }
            
            switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self.configureUIElements(with: user)
                    }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(alertTitle: "something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        self.add(childVC: GFUserinfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.dataLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo,dataLabel]
        
        for itemView in itemViews {
            // add headerView as a subView to the main view
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
            itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: padding),
            itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -padding)
            ])
        }
        
        // constraint for header view w.r.t main viewController
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
        
            dataLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dataLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    
    func add(childVC: UIViewController , to containerView: UIView) {
        // add the childview to main viewController (optional)
        addChild(childVC)
        // add the childview as a subView to headerView
        containerView.addSubview(childVC.view)
        // control the size of childview
        childVC.view.frame = containerView.bounds
        // optional
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension UserinfoVC: GFRepoItemVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        // call safari vc
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(alertTitle: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
}

extension UserinfoVC: GFFollowerItemVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(alertTitle: "No Followers", message: "This user has no followers. What a shame 😞", buttonTitle: "So sad")
            return
        }
        // dismiss current vc
        // tell follower list screen the new user
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
