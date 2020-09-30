//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Apple on 9/8/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    
    let logoImageView = UIImageView()
    let userNameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUserNameEntered: Bool {
        return !userNameTextField.text!.isEmpty
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // backgroun white in lightMode and black in darkMode
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, userNameTextField, callToActionButton)
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        everyTime the view appear the edit text field will clear the content
        userNameTextField.text = ""
        //navigationController?.isNavigationBarHidden = true
        // we use setNavigationBarHidden because in transition between two screens the bar we want not to be disappeared
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowerListVC() {
        
        guard isUserNameEntered else{
            presentGFAlertOnMainThread(alertTitle: "Empty User Name", message: "Please Enter a user name. We need to know who to look for 😄.", buttonTitle: "Ok")
            return
        }
//        dismiss the keyboard
//        view.endEditing(true)
        userNameTextField.resignFirstResponder()
        
        let followerListVC = FollowersListVC(userName: userNameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
        
    }
    
    
    func configureLogoImageView() {
//        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghImage
        
        let topConstraintsConstant: CGFloat = DeviceTypes.isiphoneSE || DeviceTypes.isiphone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintsConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureTextField() {
//        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton() {
//        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
        
    }
    
}
