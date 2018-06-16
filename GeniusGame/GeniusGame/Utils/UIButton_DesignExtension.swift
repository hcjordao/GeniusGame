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
}
