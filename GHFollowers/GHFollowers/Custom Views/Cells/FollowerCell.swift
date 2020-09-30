//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Apple on 9/12/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    // important the identifier of the cell
    static let reuseID = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        avatarImageView.downloadImage(fromURL: follower.avatarUrl)
        usernameLabel.text = follower.login
    }
    
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
//        addSubview(avatarImageView)
//        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            // equalTo: avatarImageView.widthAnchor  because we need it to be square at all screen sizes
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            // constant 20 because usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
