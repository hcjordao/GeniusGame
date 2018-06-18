//
//  Float+Extensions.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 18/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import Foundation

extension Float {
    func rounded(toPlaces places:Int) -> Float {
        let divisor: Float = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
