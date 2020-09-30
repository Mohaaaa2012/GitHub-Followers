//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Apple on 9/9/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentGFAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        // because we call dismiss function from background thread in closure after the network call end
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message:String , in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
