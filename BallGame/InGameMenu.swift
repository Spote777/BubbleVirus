//
//  InGameDecoration.swift
//  bbtan
//
//  Created by Schmit Yanis on 11/04/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene{
    
    func createInGameBackground() {
        backgroundGame = SKSpriteNode(imageNamed: "background")
        backgroundGame.size.width = self.size.width
        backgroundGame.size.height = self.size.height
        backgroundGame.zPosition = -1
        backgroundGame.scene?.scaleMode = .aspectFill
        self.addChild(backgroundGame)
    }
    
    func createInGameMenuTop() {
        // setting up the rectangle which is the base of the upper menu in the game
        menuRect = SKShapeNode(rectOf: CGSize(width: self.frame.width, height: self.frame.height / 2 - yPositionUp))
        menuRect.position = CGPoint(x: 0, y: yPositionUp + menuRect.frame.height / 2)
        menuRect.fillColor = SKColor.clear
        menuRect.strokeColor = SKColor.clear
        menuRect.zPosition = 4
        menuRect.name = "menuRect"
        self.addChild(menuRect)
        
        // setting up the scorelabel in the main game... you'll probably get it for the next ones:)
        scoreLabel = SKLabelNode(text: "1")
        scoreLabel.fontSize = self.frame.width / 8
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: 0, y: yPositionUp + 30)
        scoreLabel.zPosition = 5
        scoreLabel.name = "scoreLabel"
        self.addChild(scoreLabel)
        
        highscoreLabel = SKLabelNode(text: "\(highscore)")
        highscoreLabel.fontSize = self.size.width / 13
        highscoreLabel.fontName = "AvenirNext-Bold"
        highscoreLabel.fontColor = SKColor.black
        highscoreLabel.position = CGPoint(x: self.frame.width / 2 - 1.5 * highscoreLabel.frame.height, y: yPositionUp + 0.65 * (highscoreLabel.frame.height))
        highscoreLabel.zPosition = 6
        highscoreLabel.name = "highscoreLabel"
        self.addChild(highscoreLabel)
        
        bestLabel = SKSpriteNode(imageNamed: "best BUTTON")
        bestLabel.size.width = self.frame.width / 6
        bestLabel.size.height = self.frame.width / 6
        bestLabel.anchorPoint = CGPoint(x: 0.5 ,y: 0.5)
        bestLabel.position = CGPoint(x: self.frame.width / 2 - 1.5 * highscoreLabel.frame.height, y: yPositionUp + 1.75 * (highscoreLabel.frame.height))
//        bestLabel.position = CGPoint(x: self.frame.width / 2.7 , y:yPositionUp + self.frame.height / bestLabel.size.width * 1.2)
        bestLabel.zPosition = 5
        bestLabel.name = "topLabel"
        self.addChild(bestLabel)
    }
    
    func createPauseButton() {
        pauseButton = PlaybackButton(frame: CGRect(x: self.frame.width / 35, y: self.frame.width / 35, width: 65, height: 65 ))
        pauseButton.setImage(UIImage(named: "pause button(glow)"), for: .normal)
        pauseButton.adjustMargin = 1
        pauseButton.backgroundColor = UIColor.clear
        pauseButton.addTarget(self, action: #selector(didTapPauseButton(_:)), for: UIControl.Event.touchUpInside)
        self.pauseButton.setButtonState(.playing, animated: false)
        self.scene?.view?.addSubview(self.pauseButton)
    }
    
    @objc func didTapPauseButton(_ sender: AnyObject) {
        if self.pauseButton.buttonState == .playing {
            self.pauseButton.setButtonState(.pausing, animated: true)
            self.pauseButton.setImage(UIImage(named: "play button"), for: .normal)
            //labelTimer.invalidate()
        } else if self.pauseButton.buttonState == .pausing {
            self.pauseButton.setButtonState(.playing, animated: true)
            self.pauseButton.setImage(UIImage(named: "pause button(glow)"), for: .normal)
            startLabelTimer()
        }
    }
    
    func createNumberOfBulletsLabel() {
        // creating the small label besides the balls on the ground to know how many are left to shoot
        bulletsLeftLabel = SKLabelNode(text: "\(numberOfBullets)")
        bulletsLeftLabel.fontSize = self.frame.width / 20
        bulletsLeftLabel.fontName = "AvenirNext-Bold"
        bulletsLeftLabel.fontColor = SKColor.white
        // deciding whether the label should be on the right or on the left of the ball
        if origin.x >= 0{
            bulletsLeftLabel.position = CGPoint(x: origin.x -  1.2*mainBullet.frame.width, y: origin.y - bulletsLeftLabel.frame.height / 2)
        }else {
            bulletsLeftLabel.position = CGPoint(x: origin.x + 1.2*mainBullet.frame.width, y: origin.y - bulletsLeftLabel.frame.height / 2)
        }
        bulletsLeftLabel.zPosition = 5
        bulletsLeftLabel.name = "ballsLeftLabel"
        self.addChild(bulletsLeftLabel)
    }
    
    func createInGameMenuBottom() {
        timeLabel.isHidden = false
        timeLabel = SKLabelNode(text: "\(timeLeftMin):\(timeLeftSec)")
        timeLabel.fontSize = self.frame.width / 8
        timeLabel.fontName = "AvenirNext-Bold"
        timeLabel.position = CGPoint(x: 0, y: -self.frame.height / 2 + timeLabel.frame.height / 3.8)
        timeLabel.zPosition = 3
        timeLabel.name = "timeLabel"
        self.addChild(timeLabel)
    }
}
