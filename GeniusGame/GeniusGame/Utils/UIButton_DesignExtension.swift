//
//  UIButton_DesignMenu.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 16/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit

extension UIButton {
    func setupMenuUI() {
        self.backgroundColor = .black
        self.setTitleShadowColor(.white, for: .normal)
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func highlightButton(){
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 15
    }
    
    func unhiglightButton(){
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 15
    }
}
