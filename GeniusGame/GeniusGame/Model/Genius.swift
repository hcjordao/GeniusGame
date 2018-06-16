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

enum GameState{
    case start,pause,play,showSequence,end
}

class Genius {
    
    var state: GameState
    var sequence: [Int] = []
    var sequenceCount: Int = 0
    var playerProgress: Int = 0
  
    
    init(difficulty: Difficulty){
        state = .start
//        self.difficulty = difficulty
//        self.colors = [["On":"btnOneOn","Off":"btnOneOff"],["On":"btnTwoOn","Off":"btnTwoOff"],["On":"btnThreeOn","Off":"btnThreeOff"],["On":"btnFourOn","Off":"btnFourOff"]]
    }
    
    func checkInput(with value: Int) {
        if value == sequence[playerProgress] {
            playerProgress += 1
            //Play Sound
            if playerProgress == sequence.count {
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
    
    func readyForInput() {
        playerProgress = 0
        state = .play
    }
    
    func gameEnd(){
        playerProgress = 0
        print("End")
    }
}
