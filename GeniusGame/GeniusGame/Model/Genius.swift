//
//  Genius.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 15/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import Foundation

enum GameState{
    case play,showSequence,end
}

enum Difficulty: TimeInterval{
    case easy = 0.5
    case medium = 0.4
    case hard = 0.3
    case extreme = 0.1
    
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
        }
        return multiplier
    }
    
    func getDifficultyName() -> String{
        var name: String
        switch self {
        case .easy:
            name = "easy"
        case .medium:
            name = "medium"
        case .hard:
            name = "hard"
        case .extreme:
            name = "extreme"
        }
        return name
    }
    
    static func getDifficultyFromName(name: String) -> Difficulty {
        var difficulty: Difficulty = .easy
        switch name {
        case "easy":
            difficulty = .easy
        case "medium":
            difficulty = .medium
        case "hard":
            difficulty = .hard
        case "extreme":
            difficulty = .extreme
        default:
            break
        }
        return difficulty
    }
}

class Genius {
    
    var state: GameState
    var sequence: [Int] = []
    var sequenceCount: Int = 0
    var playerProgress: Int = 0
    var score: Float
    var difficulty: Difficulty
    var soundEffects: [String]
    var player: Player
    
    init(difficulty: Difficulty){
        self.state = .showSequence
        self.difficulty = difficulty
        self.soundEffects = []
        self.score = 0
        self.player = Player()
    }
    
    func checkInput(with value: Int) {
        if value == sequence[playerProgress] {
            playerProgress += 1
            if playerProgress == sequence.count {
                playerScored()
                extendSequence()
            }
        } else {
            gameEnd()
        }
    }
    
    func extendSequence(){
        let randomChoice = Int(arc4random_uniform(4))
        sequence.append(randomChoice)
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
    
    func changeDifficulty(with difficulty: Difficulty){
        self.player.difficultyPlayed = difficulty.getDifficultyName()
        self.difficulty = difficulty
    }
    
    func loadSongs(with pack:[String]){
        soundEffects = pack
    }
    
    func gameEnd(){
        state = .end
        player.score = score
        score = 0
        playerProgress = 0
    }
}
