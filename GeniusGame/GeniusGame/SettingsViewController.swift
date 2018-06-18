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
    
    var userSettings: Settings!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        if sender.value == 0 {
            volumeLbl.text = "Muted"
        } else if sender.value == 1{
            volumeLbl.text = "Max"
        } else {
            volumeLbl.text = "\(sender.value.rounded(toPlaces: 2))"
        }
        userSettings.volume = sender.value
    }
    
    @IBAction func packButtonPressed(_ sender: UIButton) {
        if let index = packButtons.index(of: sender){
            switch index{
            case 0:
                packButtons[0].highlightButton()
                packButtons[1].unhiglightButton()
                userSettings.soundEffectPack = SoundEffectPacks.packOne
            default:
                packButtons[1].highlightButton()
                packButtons[0].unhiglightButton()
                userSettings.soundEffectPack = SoundEffectPacks.packOne
            }
        }
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            userSettings.difficulty = .easy
        case 1:
            userSettings.difficulty = .medium
        case 2:
            userSettings.difficulty = .hard
        default:
            userSettings.difficulty = .extreme
        }
    }
    
    func setupUI(){
        //Adding Gradient View to View
        let color0 = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        let color1 = UIColor(red:207.0/255, green:222.0/255, blue:243.0/255, alpha:1)
        self.view.createGradient(with: color0, and: color1)
        
        homeView.setupHomeView()
        
        loadSettingsUI()
    }
    
    func loadSettingsUI(){
        volumeSlider.value = userSettings.volume
        sliderChanged(volumeSlider)
        
        switch userSettings.difficulty {
        case .easy:
            difficultySegmentedControl.selectedSegmentIndex = 0
        case .medium:
            difficultySegmentedControl.selectedSegmentIndex = 1
        case .hard:
            difficultySegmentedControl.selectedSegmentIndex = 2
        case .extreme:
            difficultySegmentedControl.selectedSegmentIndex = 3
        }
        
        if userSettings.soundEffectPack == SoundEffectPacks.packOne {
            packButtons[0].highlightButton()
            packButtons[1].unhiglightButton()
        } else {
            packButtons[1].highlightButton()
            packButtons[0].unhiglightButton()
        }
    }
}
