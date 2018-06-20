//
//  Settings.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 16/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import Foundation

//struct Settings: NSObject, NSCoding {
//    var volume: Float
//    var difficulty: Difficulty
//    var soundEffectPack: [String]
//
//    static func `default`() -> Settings{
//        return Settings(volume: 0.5, difficulty: .extreme, soundEffectPack: SoundEffectPacks.packOne)
//    }
//}

class Settings: NSObject, NSCoding{
    
    var volume: Float
    var difficulty: Difficulty
    var soundEffectPack: [String]
    
    init(volume: Float = 0.5, difficulty: Difficulty = .easy, soundEffectPack: [String] = SoundEffectPacks.packOne) {
        self.volume = volume
        self.difficulty = difficulty
        self.soundEffectPack = soundEffectPack
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let volume = aDecoder.decodeFloat(forKey: "volume")
        let difficulty = aDecoder.decodeObject(forKey: "difficulty") as! String
        let soundEffectPacks = aDecoder.decodeObject(forKey: "soundEffect") as! [String]
        let getDifficulty = Difficulty.getDifficultyFromName(name: difficulty)
        self.init(volume: volume, difficulty: getDifficulty, soundEffectPack: soundEffectPacks)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.volume, forKey: "volume")
        aCoder.encode(self.difficulty.getDifficultyName(), forKey: "difficulty")
        aCoder.encode(self.soundEffectPack, forKey: "soundEffect")
    }
}
