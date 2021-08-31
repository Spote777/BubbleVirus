//
//  Time.swift
//  bbtan
//
//  Created by Schmit Yanis on 27/03/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene{
    func startLabelTimer() {
        // the timer which makes the countdown in the main game
        labelTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
    }
    
    func startBulletTimer() {
        // the timer which controls how quickly the bullets are shot
        bulletTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(shootBullets), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeLabel() {
        // the function which updates the countdown every second as it it called by the labelTimer every second
        timeLeftSec -= 1
        if timeLeftSec < 1{
            timeLeftSec = 59
            timeLeftMin -= 1
        }
        if timeLeftSec > 9{
            timeLabel.text = "\(timeLeftMin):\(timeLeftSec)"
        }else{
            timeLabel.text = "\(timeLeftMin):0\(timeLeftSec)"
        }
    }
}
