//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

protocol GFFollowerItemVCDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemVCDelegate!
    
    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureitems()
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
    
    func configureitems() {
        itemInfoViewOne.set(itemInfoType: .follower, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
