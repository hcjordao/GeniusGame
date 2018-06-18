//
//  SettingsViewController.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 16/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var volumeLbl: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet var packButtons: [UIButton]!
    @IBOutlet weak var difficultySegmentedControl: UISegmentedControl!
    @IBOutlet weak var homeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI(){
        //Adding Gradient View to View
        let color0 = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        let color1 = UIColor(red:207.0/255, green:222.0/255, blue:243.0/255, alpha:1)
        self.view.createGradient(with: color0, and: color1)
        
        homeView.setupHomeView()
    }
}
