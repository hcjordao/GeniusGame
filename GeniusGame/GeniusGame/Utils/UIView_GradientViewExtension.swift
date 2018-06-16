//
//  UIVIew_GradientViewExtension.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 16/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit

extension UIView {
    
    func createGradient(with color0: UIColor, and color1:UIColor){
        let gradientView = GradientView(frame: self.frame, colors: [color0,color1])
        gradientView.firstColor = color0
        gradientView.secondColor = color1
        self.insertSubview(gradientView, at: 0)
    }
}
