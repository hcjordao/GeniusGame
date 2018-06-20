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
    var score: Float
    
    init(name: String = "", score: Float = 0) {
        self.name = name
        self.score = score
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let score = aDecoder.decodeObject(forKey: "score") as! Float
    
        self.init(name: name, score: score)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.score, forKey: "score")
    }
}
