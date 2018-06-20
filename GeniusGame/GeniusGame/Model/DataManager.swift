//
//  DataManager.swift
//  GeniusGame
//
//  Created by Henrique Jordão on 19/06/18.
//  Copyright © 2018 Henrique Jordão. All rights reserved.
//

import Foundation

class DataManager {
    
    var userSettings: Settings
    var topTen:[Player]
    
    private static var sharedDataManager: DataManager = {
        let dataManager = DataManager()
        return dataManager
    }()
    
    private init(){
        userSettings = Settings()
        topTen = []
    }
    
    class func shared() -> DataManager {
        return sharedDataManager
    }
    
    func fetchDataFromUserDefaults(){
        unarchiveSettings()
        unarchiveTopTen()
    }
    
    func update(newSettings: Settings) {
        self.userSettings = newSettings
        self.archiveSettings()
    }
    
    func update(newPlayer: Player){
        if topTen.isEmpty {
            topTen.append(newPlayer)
        } else {
            for i in self.topTen.indices{
                if newPlayer.score > topTen[i].score{
                    self.topTen.insert(newPlayer, at: i)
                    if topTen.count == 11 {
                        topTen.removeLast()
                    }
                }
            }
        }
        self.archiveTopTen()
    }
    
    func archiveSettings(){
        let userDefaults = UserDefaults.standard
        let settings = DataManager.shared().userSettings
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: settings)
        userDefaults.set(encodedData, forKey: "settings")
        
    }
    
    func archiveTopTen(){
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: DataManager.shared().topTen)
        userDefaults.set(encodedData, forKey: "topTen")
    }
    
    private func unarchiveSettings(){
        let userDefaults = UserDefaults.standard
        let decoded = userDefaults.object(forKey: "settings") as? Data ?? Data()
        DataManager.shared().userSettings = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Settings ?? Settings()
    }
    
    private func unarchiveTopTen() {
        let userDefaults = UserDefaults.standard
        let decoded = userDefaults.object(forKey: "topTen") as? Data ?? Data()
        DataManager.shared().topTen = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [Player] ?? []
    }
    
    func resetUser(){
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
