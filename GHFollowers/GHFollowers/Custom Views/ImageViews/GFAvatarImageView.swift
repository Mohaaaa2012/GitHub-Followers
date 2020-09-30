//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Apple on 9/12/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placeHolderImage = Images.placeholder
    let cashe = NetworkManager.shared.cashe
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        // A Boolean value that determines whether subviews are confined to the bounds of the view.
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
