//
//  GameViewController.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 14/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
   
    //Outlets
    @IBOutlet weak var bestPlayerScoreLbl: UILabel!
    @IBOutlet weak var instructionLbl: UILabel!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet var geniusButtons: [UIButton]!

    //Properties
    var genius: Genius!
    var soundPlayer: AVAudioPlayer?
    var tapView: UIView!
    var userSettings: Settings {
        return DataManager.shared().userSettings
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func touchButton(_ sender: UIButton){
        if let index = geniusButtons.index(of: sender){
            genius.checkInput(with: index)
            if genius.state == .showSequence {
                //Show Extended Sequence To Player.
                displayScore()
                playSound(of: index)
                showSequence()
            }else if genius.state == .end {
                displayScore()
                gameEnded()
            } else {
                //Regular Player Move.
                playSound(of: index)
            }
        }
    }
    
    @objc func startGame() {
        tapView.isHidden = true
        sendInstruction(with: "Pay Attention...")
        genius = Genius(difficulty: .extreme)
        applyUserSettings()
        genius.extendSequence()
        showSequence()
    }
    
    func gameEnded(){
        performSegue(withIdentifier: "gameOverSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameOverSegue" {
            let destinationVC = segue.destination as! GameOverViewController
            destinationVC.player = genius.player
        }
    }
    
    func sendInstruction(with message: String){
        self.instructionLbl.text = message
    }
    
    func applyUserSettings(){
        genius.changeDifficulty(with: userSettings.difficulty)
        genius.loadSongs(with: userSettings.soundEffectPack)
    }
    
    func displayScore(){
        scoreLbl.text = "\(Int(genius.score))"
    }
    
    func showSequence(){
        changeButtonInteraction(to: false)
        sendInstruction(with: "Pay Attention...")
        genius.sequenceCount = 0
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (_) in
            self.highlightNextButton()
        }
    }
    
    func playSound(of index: Int){
        let soundName = genius.soundEffects[index]
        let volume = userSettings.volume
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
    
            soundPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let soundPlayer = soundPlayer else { return }
            soundPlayer.volume = volume
            soundPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func highlightNextButton(){
        let button = geniusButtons[genius.sequence[genius.sequenceCount]]
        let difficultyTimer = genius.difficulty.rawValue
        DispatchQueue.main.async {
            UIView.transition(with: button,
                              duration: difficultyTimer,
                              options: .transitionCrossDissolve,
                              animations: { button.isHighlighted = true },
                              completion: self.dimNextButton)
        }
    }
    
    func dimNextButton(_: Bool) -> Void{
        let index = genius.sequence[genius.sequenceCount]
        let button = geniusButtons[genius.sequence[genius.sequenceCount]]
        let difficultyTimer = genius.difficulty.rawValue
        DispatchQueue.main.async {
            self.playSound(of: index)
            UIView.transition(with: button,
                              duration: difficultyTimer,
                              options: .transitionCrossDissolve,
                              animations: { button.isHighlighted = false },
                              completion: self.increaseSequenceCount)
        }
    }
    
    func increaseSequenceCount(_: Bool) -> Void {
        genius.sequenceCount += 1
        if genius.sequenceCount < genius.sequence.count {
            highlightNextButton()
            return
        }
        changeButtonInteraction(to: true)
        sendInstruction(with: "Your Turn...")
        genius.readyForInput()
    }
    
    func changeButtonInteraction(to isEnabled: Bool){
        for button in geniusButtons {
            button.isUserInteractionEnabled = isEnabled
        }
    }
    
    @IBAction func unwindFromGameOver(_ sender: UIStoryboardSegue){
        if sender.source is GameOverViewController {
            self.tapView.isHidden = false
            loadBestPlayerScore()
            sendInstruction(with: "Tap to play...")
        }
    }
    
    func loadBestPlayerScore(){
        let players = DataManager.shared().topTen
        var scoreText: String
        if !players.isEmpty{
            scoreText = "\(Int(players[0].score))"
        } else {
            scoreText = "0"
        }
        self.bestPlayerScoreLbl.text = "BEST: " + scoreText
    }
    
    func setup(){
        let color0 = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        let color1 = UIColor(red:207.0/255, green:222.0/255, blue:243.0/255, alpha:1)
        view.createGradient(with: color0, and: color1)
        
        scoreLbl.text = "0"
        
        homeView.setupView()
        
        loadBestPlayerScore()

        self.tapView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: homeView.frame.origin.y))
        self.view.insertSubview(tapView, at: 10)
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tap.addTarget(self, action: #selector(GameViewController.startGame))
        tapView.addGestureRecognizer(tap)
    }
}

