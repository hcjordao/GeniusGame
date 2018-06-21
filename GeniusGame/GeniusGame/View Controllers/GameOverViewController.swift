//
//  GameOverViewController.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 19/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var retryView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var nameTexfield: UITextField!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet var additionalLbls: [UILabel]!
    
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func playerDidEnterTopTen() -> Bool{
        let currentTopTen = DataManager.shared().topTen
        
        if currentTopTen.isEmpty || currentTopTen.count < 10 {
            return true
        }
        
        for player in currentTopTen {
            if player.score > player.score {
                return true
            }
        }
        
        return false
    }
    
    @objc func viewTapped(){
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if playerDidEnterTopTen()  {
            DataManager.shared().update(newPlayer: player)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if self.nameTexfield.isEmpty() && self.nameTexfield.isHidden == false {
            self.nameTexfield.shake()
            return false
        }
        return true
    }
    
    func setup(){
        //Adding Gradient View to View
        let color0 = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        let color1 = UIColor(red:207.0/255, green:222.0/255, blue:243.0/255, alpha:1)
        self.view.createGradient(with: color0, and: color1)
        
        retryView.setupView()
        
        homeView.setupView()
        
        scoreLbl.text = "\(player.score.rounded(toPlaces: 2))"
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tap.addTarget(self, action: #selector(GameOverViewController.viewTapped))
        self.view.addGestureRecognizer(tap)
        
        nameTexfield.delegate = self
        
        if !playerDidEnterTopTen() {
            for label in self.additionalLbls {
                label.isHidden = true
            }
            nameTexfield.isHidden = true
        }
    }
}

extension GameOverViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            player.name = text
        }
        return true
    }
}

