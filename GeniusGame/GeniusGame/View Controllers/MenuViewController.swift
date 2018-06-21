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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingsSegue" {
            let destinationVC = segue.destination as! SettingsViewController
            destinationVC.userSettings = DataManager.shared().userSettings
        }
    }
    
    @IBAction func unwindFromSegue(_ sender: UIStoryboardSegue){
        if sender.source is SettingsViewController {
            let sourceVC = sender.source as! SettingsViewController
            DataManager.shared().update(newSettings: sourceVC.userSettings)
        }
    }
    
    func setup(){
        let color0 = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        let color1 = UIColor(red:207.0/255, green:222.0/255, blue:243.0/255, alpha:1)
        self.view.createGradient(with: color0, and: color1)
        
        for button in menuButtons {
            button.setupMenuUI()
        }
    }
}
