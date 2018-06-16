//
//  Genius.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 15/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import Foundation

enum Difficulty: TimeInterval{
    case easy = 0.5
    case medium = 0.4
    case hard = 0.3
    case extreme = 0.2
    case insane = 0.1
    
    func difficultyMultiplier() -> Float {
        var multiplier: Float = 0
        switch self {
        case .easy:
            multiplier = 1
        case .medium:
            multiplier = 1.25
        case .hard:
            multiplier = 1.5
        case .extreme:
            multiplier = 2
        case .insane:
            multiplier = 3
        }
        return multiplier
    }
}

enum GameState{
    case pause,play,showSequence,end
}

class Genius {
    
    var state: GameState
    var sequence: [Int] = []
    var sequenceCount: Int = 0
    var playerProgress: Int = 0
    var score: Float
    var difficulty: Difficulty
  
    
    init(difficulty: Difficulty){
        self.state = .showSequence
        self.difficulty = difficulty
        self.score = 0
    }
    
    func checkInput(with value: Int) {
        if value == sequence[playerProgress] {
            playerProgress += 1
            //Play Sound
            if playerProgress == sequence.count {
                playerScored()
                extendSequence()
            }
        } else {
            gameEnd()
        }
    }
    
    func playSound(of index: Int){
        
    }
    
    func extendSequence(){
        //Increase pattern if player succeded in completing previous pattern
        let randomChoice = Int(arc4random_uniform(4))
        sequence.append(randomChoice)
        
        print(sequence)
        state = .showSequence
    }
    
    func playerScored(){
        let difficultyMultiplier  = difficulty.difficultyMultiplier()
        score += (10 * difficultyMultiplier)
    }
    
    func readyForInput() {
        playerProgress = 0
        state = .play
    }
    
    func gameEnd(){
        score = 0
        playerProgress = 0
        print("End")
    }
}
