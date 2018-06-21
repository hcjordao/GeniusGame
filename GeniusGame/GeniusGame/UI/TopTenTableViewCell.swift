//
//  TopTenTableViewCell.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 20/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit

class TopTenTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerDifficultyLbl: UILabel!
    @IBOutlet weak var playerScoreLbl: UILabel!
    @IBOutlet weak var positionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    func setupCell(with player: Player, and position: Int){
        self.playerNameLbl.text = player.name
        self.playerDifficultyLbl.text = player.difficultyPlayed
        self.playerScoreLbl.text = "\(player.score)"
        self.positionLbl.text = "\(position + 1)" + "."
    }
    
}
