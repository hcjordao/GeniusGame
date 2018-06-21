//
//  TopTenViewController.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 20/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import UIKit

class TopTenViewController: UIViewController {

    @IBOutlet weak var topTenTblView: UITableView!
    @IBOutlet weak var homeView: UIView!
    
    var players: [Player] {
        return DataManager.shared().topTen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    func setupUI(){
        let color0 = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        let color1 = UIColor(red:207.0/255, green:222.0/255, blue:243.0/255, alpha:1)
        self.view.createGradient(with: color0, and: color1)

        homeView.setupView()
    }
}

extension TopTenViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(){
        self.topTenTblView.delegate = self
        self.topTenTblView.dataSource = self
        self.topTenTblView.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topTenTblView.dequeueReusableCell(withIdentifier: "topTenCell", for: indexPath) as! TopTenTableViewCell
        
        cell.setupCell(with: players[indexPath.row], and: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
