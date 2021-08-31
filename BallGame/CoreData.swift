//
//  CoreData.swift
//  bbtan
//
//  Created by Schmit Yanis on 12/04/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation

extension GameScene{
    func loadHighScore() {
        // if there is a saved highscore it is loaded
        if savedHighscore != nil {
            highscore = savedHighscore!
        }else {
            highscore = 1
        }
    }
    
    func saveHighScore() {
        // saving the highscore in coredata
        UserDefaults.standard.set(highscore, forKey: "highscore")
        UserDefaults.standard.synchronize()
//        print("saved highscore")
    }
}
