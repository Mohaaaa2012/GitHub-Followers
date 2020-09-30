//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Apple on 9/13/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    var messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 24)
    var logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    func configure() {
        addSubviews(messageLabel, logoImageView)
        configureMessageLabel()
        configureLogoImageView()
    }
    
    
    private func configureMessageLabel() {
//        addSubview(messageLabel)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        let LabelCenterYConstant: CGFloat = DeviceTypes.isiphoneSE || DeviceTypes.isiphone8PlusZoomed ? -80 : -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: LabelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 200)
        ])
    }
    
    
    private func configureLogoImageView() {
//        addSubview(logoImageView)
        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstant: CGFloat = DeviceTypes.isiphoneSE || DeviceTypes.isiphone8Zoomed ? 80 : 40
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
        ])
    }
}
