//
//  Player.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 20/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import Foundation

class Player: NSObject, NSCoding {

    var name: String
    var difficultyPlayed: String
    var score: Float
    
    init(name: String = "", difficultyPlayed: String = "easy",score: Float = 0) {
        self.name = name
        self.difficultyPlayed = difficultyPlayed
        self.score = score
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let score = aDecoder.decodeFloat(forKey: "score")
        let difficultyPlayed = aDecoder.decodeObject(forKey: "difficultyPlayed") as! String
        self.init(name: name, difficultyPlayed: difficultyPlayed, score: score)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.score, forKey: "score")
        aCoder.encode(self.difficultyPlayed, forKey: "difficultyPlayed")
    }
}
