//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Apple on 9/8/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.systemGray4.cgColor
        
        textColor          = .label
        tintColor          = .label
        textAlignment      = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        // adjust the font size if the text is bigger than the textField window
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12

        backgroundColor = .tertiarySystemBackground
        returnKeyType   = .go
        autocorrectionType = .no
        // x sign refer to remove the written text appear beside the texet entered 
        clearButtonMode = .whileEditing
        placeholder = "Enter a Username"
        
    }
}
