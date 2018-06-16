//
//  MenuViewController.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 16/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var menuButtons: [UIButton]!
    @IBOutlet weak var geniusLbl: UILabel!
    
    //First Load of the game is equal to a default settings
    var userSettings: Settings = Settings.default()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If segue is going to the game
        if segue.identifier == "gameSegue" {
            //Sending info from this VC to the next VC
            let destinationVC = segue.destination as! GameViewController
            destinationVC.userSettings = userSettings
        }
    }

    func setupUI(){
        //Adding Gradient View to View
        let color0 = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        let color1 = UIColor(red:207.0/255, green:222.0/255, blue:243.0/255, alpha:1)
        self.view.createGradient(with: color0, and: color1)
        
        for button in menuButtons {
            //Apply UI For All buttons.
        }
        
        
    }
}
