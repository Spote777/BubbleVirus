//
//  EndCreateGame.swift
//  bbtan
//
//  Created by Schmit Yanis on 27/03/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import SpriteKit
import GoogleMobileAds

extension GameScene{
    
    func startGame() {
        //resetting all variables and starting a new game
        isInMenu = false
        isInGameOverView = false
        gameOver = false
        xPosition = -self.frame.width  / 2 + self.frame.width / 14
        numberOfBullets = 0
        wave = 0
        touchIsEnabled = true
        isFirstBulletTouchingBottom = true
        pauseButton.isHidden = false
        timeLeftMin = 29
        timeLeftSec = 59
        
        // hiding the ad
        showHideAd()
        // preloading the video ad
       // rewardedAd.load(GADRequest(),withAdUnitID: "ca-app-pub-7425760799934446/7674194215")
//        GADInterstitialAd.load(GADRequest())
        // creating all the components of the game
        startLabelTimer()
        createInGameMenuTop()
        createInGameBackground()
        //createInGameMenuBottom()
        createBorder()
        createBoxes()
        showBullet()
        createNumberOfBulletsLabel()
       
        // changing its position because when the round hasn't started yet the position has to be based on the mainbullet and not on the origin
        if mainBullet.position.x >= 0 {
            bulletsLeftLabel.position = CGPoint(x: mainBullet.position.x -  mainBullet.frame.width, y: mainBullet.position.y - bulletsLeftLabel.frame.height / 2)
        }else {
            bulletsLeftLabel.position = CGPoint(x: mainBullet.position.x +  mainBullet.frame.width, y: mainBullet.position.y - bulletsLeftLabel.frame.height / 2)
        }
        updateTimeLabel()
    }
    
    func checkIfRoundIsOver() {
        //check if the round has finished to spawn a new wave of boxes
        roundOver = true
        for node in self.children {
            // check if there are bullets left on gamefield or if bullets haven't been shot yet
            if node.name == "bullet" || bulletsShot < numberOfBullets{
                roundOver = false
            }
        }
        if roundOver {
            createBoxes()
            createNumberOfBulletsLabel()
            // changing its position because when the round hasn't started yet the position has to be based on the mainbullet and not on the origin
            if mainBullet.position.x >= 0 {
                bulletsLeftLabel.position = CGPoint(x: mainBullet.position.x -  mainBullet.frame.width, y: mainBullet.position.y - bulletsLeftLabel.frame.height / 2)
            }else {
                bulletsLeftLabel.position = CGPoint(x: mainBullet.position.x +  mainBullet.frame.width, y: mainBullet.position.y - bulletsLeftLabel.frame.height / 2)
            }
            // looking for new highscore, if new highscore -> saving it in core data
            if wave > highscore {
                highscore = wave
                highscoreLabel.text = "\(highscore)"
                saveHighScore()
            }
            scoreLabel.text = "\(wave)"
            touchIsEnabled = true
            isFirstBulletTouchingBottom = true
        }
    }
    
    func checkIfGameIsOver() {
        // the game is over when a box has moved to the bottom
        if !gameOver{
            for node in self.children{
                if let box = node as? Box{
                    // a box actually touches the bottom when its property hasmoveddown equals to 9
                    if box.hasMovedDown >= 9 {
                        //pauseButton.isHidden = true
                        gameOver = true
                        //labelTimer.invalidate()
                        createGameOverView()
                    }
                }
            }
        }
    }
}


