//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Apple on 9/23/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           topAnchor.constraint(equalTo: superView.topAnchor),
           leadingAnchor.constraint(equalTo: superView.leadingAnchor),
           trailingAnchor.constraint(equalTo: superView.trailingAnchor),
           bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
