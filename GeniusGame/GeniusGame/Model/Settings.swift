//
//  Settings.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 16/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import Foundation

struct Settings {
    var volume: Int
    var difficulty: Difficulty
    var soundEffectPack: [Int]
    var isMuted: Bool
    
    static func `default`() -> Settings{
        return Settings(volume: 1, difficulty: .easy, soundEffectPack: [], isMuted: false)
    }
}
