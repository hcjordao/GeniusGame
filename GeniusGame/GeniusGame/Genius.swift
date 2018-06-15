//
//  Genius.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 15/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import Foundation

enum Difficulty{
    case easy, medium, hard
}

class Genius {
    
    var pattern: [Int] = []
    var mimickedPattern: [Int] = []
    let difficulty: Difficulty
    
    init(difficulty: Difficulty){
        self.difficulty = difficulty
    }
    
    func incrementPattern(){
        let randomChoice = Int(arc4random_uniform(4))
        self.pattern.append(randomChoice)
    }
}
