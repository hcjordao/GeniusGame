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
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet var geniusButtons: [UIButton]!

    //Properties
    var genius: Genius!
    var userSettings: Settings!
    var soundPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        test()
    }
    
    func test() -> Void {
        let rect = CGRect(x: 50, y: 50, width: 50, height: 50)
        let view1 = UIView(frame: rect)
        view1.backgroundColor = UIColor.black
        self.view.addSubview(view1)
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tap.addTarget(self, action: #selector(GameViewController.startGame))
        view1.addGestureRecognizer(tap)
    }
    
    @IBAction func touchButton(_ sender: UIButton){
        if let index = geniusButtons.index(of: sender){
            genius.checkInput(with: index)
            if genius.state == .showSequence {
                //Increment score label
                displayScore()
                playSound(of: index)
                //Extending pattern UI update
                self.showSequence()
            }else if genius.state == .end {
                //Finish the game UI Updates
                displayScore()
            } else {
                //Keep playing the game.
                playSound(of: index)
            }
        }
    }
    
    @objc func startGame() {
        genius = Genius(difficulty: .extreme)
        applyUserSettings()
        genius.extendSequence()
        showSequence()
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
        genius.readyForInput()
    }
    
    func changeButtonInteraction(to isEnabled: Bool){
        for button in geniusButtons {
            button.isUserInteractionEnabled = isEnabled
        }
    }
    
    func setupUI(){
        //Adding Gradient View to View
        let color0 = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        let color1 = UIColor(red:207.0/255, green:222.0/255, blue:243.0/255, alpha:1)
        view.createGradient(with: color0, and: color1)
        
        scoreLbl.text = "0"
        
        homeView.setupHomeView()
    }
}

