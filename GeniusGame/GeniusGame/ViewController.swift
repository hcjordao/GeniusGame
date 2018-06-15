//
//  ViewController.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 14/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Properties
    @IBOutlet var geniusButtons: [UIButton]!

    var genius: Genius!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func touchButton(_ sender: UIButton){
        if let index = geniusButtons.index(of: sender) {
            print(index)
        }
    }
    
    func startGame() {
        self.genius = Genius(difficulty: .easy)
        genius.incrementPattern()
    }
    
    func setupUI(){
        //Adding Gradient View to View
        let color0 = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        let color1 = UIColor(red:207.0/255, green:222.0/255, blue:243.0/255, alpha:1)
        let gradientView = GradientView(frame: self.view.frame, colors: [color0,color1])
        gradientView.firstColor = color0
        gradientView.secondColor = color1
        self.view.insertSubview(gradientView, at: 0)
        
    }
}

