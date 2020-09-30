//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Apple on 9/9/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        // adjust dynamic font
        adjustsFontForContentSizeCategory = true
        // adjust fontsize to fit the label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
