//
//  Settings.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 16/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import Foundation

struct Settings {
    var volume: Float
    var difficulty: Difficulty
    var soundEffectPack: [String]
    
    static func `default`() -> Settings{
        return Settings(volume: 0.5, difficulty: .extreme, soundEffectPack: SoundEffectPacks.packOne)
    }
}
