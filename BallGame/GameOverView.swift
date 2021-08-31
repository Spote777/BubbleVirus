//
//  GameOver.swift
//  bbtan
//
//  Created by Schmit Yanis on 12/04/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import SpriteKit


extension GameScene{
    func createGameOverView() {
        isInMenu = false
        isInGameOverView = true
        //pauseButton.isHidden = true
        showInterstitialAd()
        // this view is boring, only layout, there should be no questions:)
        darkerBackgroundRect = SKShapeNode(rectOf: self.frame.size)
        darkerBackgroundRect.position = CGPoint(x: 0, y: 0)
        darkerBackgroundRect.strokeColor = SKColor.black
        darkerBackgroundRect.fillColor = SKColor.black
        darkerBackgroundRect.alpha = 0.3
        darkerBackgroundRect.zPosition = 6
        darkerBackgroundRect.name = "darkerBackgroundRect"
        self.addChild(darkerBackgroundRect)
        
        menuRect = SKShapeNode(rectOf: CGSize(width: self.frame.width, height: self.frame.height / 3))
        menuRect.position = CGPoint(x: 0, y: 0)
        menuRect.strokeColor = SKColor(red: 33/255, green: 61/255, blue: 79/255, alpha: 0.65)
        menuRect.lineWidth = 0
//        menuRect.fillColor = SKColor(red: 33/255, grexren: 61/255, blue: 79/255, alpha: 0.65)
        menuRect.fillTexture = SKTexture(imageNamed: "vector_plashqque")
        menuRect.fillColor = .white
        menuRect.zPosition = 7
        menuRect.name = "menuRect"
        self.addChild(menuRect)
        
        quitButton = SKShapeNode(rectOf: CGSize(width: self.frame.width / 2.9, height: self.frame.height / 6))
        quitButton.position = CGPoint(x: -quitButton.frame.width * (7/12), y: 0)
        quitButton.fillTexture = SKTexture(imageNamed: "QUIT BUTTON")
        quitButton.fillColor = SKColor.white
        quitButton.zPosition = 8
        quitButton.name = "quitButton"
        quitButton.lineWidth = 0
        self.addChild(quitButton)
        
        watchVideoButton = SKShapeNode(rectOf: CGSize(width: self.frame.width / 2.9, height: self.frame.height / 6))
        watchVideoButton.position = CGPoint(x: watchVideoButton.frame.width * (7/12), y: 0)
        watchVideoButton.fillColor = SKColor.white
        watchVideoButton.fillTexture = SKTexture(imageNamed: "OMC BUTTON")
        watchVideoButton.zPosition = 8
        watchVideoButton.lineWidth = 0
        watchVideoButton.name = "watchVideoButton"
        self.addChild(watchVideoButton)
        
        continueLabel = SKLabelNode(text: "WHAT'S NEXT?")
        continueLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        continueLabel.fontSize = self.frame.width / 10
        continueLabel.fontName = "AvenirNext-Bold"
        continueLabel.zPosition = 7
        continueLabel.name = "continueLabel"
        self.addChild(continueLabel)
        
    }
    
    func deleteGameOverView() {
        // gets called when the user chose to watch a video ad to get one more chance
        
        darkerBackgroundRect.removeFromParent()
        menuRect.removeFromParent()
        quitButton.removeFromParent()
        watchVideoButton.removeFromParent()
        continueLabel.removeFromParent()
        endGameLabel.removeFromParent()
        oneMoreLabel.removeFromParent()
        chanceLabel.removeFromParent()
        
        isInGameOverView = false
        startLabelTimer()
        pauseButton.isHidden = false
        for child in self.children {
            if let box = child as? Box{
                // deleting the last row of boxes, so that the user can continue to play
                if box.hasMovedDown == 9 {
                    box.removeFromParent()
                    for child in self.children {
                        if box.contains(child.position){
                            child.removeFromParent()
                        }
                    }
                }
            }
        }
    }
}
