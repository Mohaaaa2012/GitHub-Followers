//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

enum itemInfoType {
    case repos,gists,following,follower
}


class GFItemInfoView: UIView {
    
    let sympolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(sympolImageView, titleLabel, countLabel)
//        addSubview(sympolImageView)
//        addSubview(titleLabel)
//        addSubview(countLabel)
        
        sympolImageView.translatesAutoresizingMaskIntoConstraints = false
        sympolImageView.contentMode = .scaleAspectFill
        sympolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            sympolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            sympolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sympolImageView.widthAnchor.constraint(equalToConstant: 20),
            sympolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: sympolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: sympolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: sympolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func set(itemInfoType: itemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            sympolImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            sympolImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .following:
            sympolImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        case .follower:
            sympolImageView.image = SFSymbols.follower
            titleLabel.text = "Followers"
        }
        
        countLabel.text = String(count)
    }

}
