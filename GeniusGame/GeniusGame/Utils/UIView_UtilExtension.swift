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
    
    func setupView(){
        self.backgroundColor = .black
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func shake(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
