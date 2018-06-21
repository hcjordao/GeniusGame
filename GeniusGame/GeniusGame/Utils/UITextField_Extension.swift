//
//  File.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 20/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit

extension UITextField {
    func isEmpty() -> Bool{
        if self.text == "" {
            return true
        }
        return false
    }
}
