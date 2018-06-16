//
//  GradientView.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 15/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var firstColor: UIColor
    var secondColor: UIColor
    
    @IBInspectable var vertical: Bool = true
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        layer.startPoint = CGPoint.zero
        return layer
    }()

    
    init(frame: CGRect, colors: [UIColor]){
        firstColor = colors[0]
        secondColor = colors[1]
        super.init(frame: frame)
        
        applyGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }
    
    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }
    
    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}
