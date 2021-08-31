//
//  Touches.swift
//  bbtan
//
//  Created by Schmit Yanis on 20/03/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics

extension GameScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // the function which gets called at the moment when the user touches the screen, so no 'complete' touch has happened yet
        for touch in touches{
            // getting the location of the touch
            let location = touch.location(in: self)
            // lookgin in which view we are
            // if the touch is on a button, the alpha of it's text is set down to give the impression of a touched button
            if isInMenu{
                if playBackGround.contains(location){
                    triangleShape.alpha = 0.6
                }else if ballBackGround.contains(location){
                    circleShape.alpha = 0.6
                }
            }else if isInGameOverView{
                if quitButton.contains(location){
                    endGameLabel.alpha = 0.6
                }else if watchVideoButton.contains(location){
                    oneMoreLabel.alpha = 0.6
                    chanceLabel.alpha = 0.6
                }
            }else if mainBullet.contains(location){
                startedTouchOnMainBullet = true
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // gets called when the touch has ended -> 'complete touch'
        // the rest is pretty much the same as in touchesBegan
        for touch in touches{
            let location = touch.location(in: self)
            if isInMenu{
                if playBackGround.contains(location){
                    self.removeAllChildren()
                    startGame()
                }else if ballBackGround.contains(location){
                    mainBullet.removeFromParent()
                    bulletSize /= 1.1
                    // changing the bullet the user gets to play with
                    if bulletColor == SKColor.white {
                        bulletColor = SKColor.red
                    }else if bulletColor == SKColor.red {
                        bulletColor = SKColor.green
                    }else if bulletColor == SKColor.green {
                        bulletColor = SKColor.blue
                    }else{
                        bulletColor = SKColor.white
                        bulletSize = self.frame.width / 35
                    }
                    createBouncingBullet()
                    circleShape.alpha = 1.0
                } else {
                    playBackGround.alpha = 1.0
                    triangleShape.alpha = 1.0
                    ballBackGround.alpha = 1.0
                    circleShape.alpha = 1.0
                }
            } else if isInGameOverView {
                if quitButton.contains(location){
                    self.removeAllChildren()
                    self.isInGameOverView = false
                    self.createMenu()
                    self.showInterstitialAd()
                } else if watchVideoButton.contains(location){
                    self.deleteGameOverView()
                    self.gameOver = false
                    self.showVideoAd()
                } else {
                    endGameLabel.alpha = 1.0
                    oneMoreLabel.alpha = 1.0
                    chanceLabel.alpha = 1.0
                }
            } else if touchIsEnabled && startedTouchOnMainBullet{
                // if we made it through all the if statements we can be sure that we can start thinking about shooting a bullet... yay:)
                if location.y < borderBottom.position.y {
                    // one last check -> the touch has to be below the bullet to give it an impulse
                    if !mainBullet.contains(location){
                        
                        bulletLocation = location
                        bulletsShot = 0
                        backGroundBullet = SKShapeNode(circleOfRadius: mainBullet.frame.width / 1.8)
                        backGroundBullet.fillTexture = SKTexture(imageNamed:"PROJECTILE")
                        backGroundBullet.fillColor = .white
//                        backGroundBullet.strokeColor = bulletColor
                        backGroundBullet.position = mainBullet.position
                        backGroundBullet.zPosition = 10
                        backGroundBullet.name = "backGroundBullet"
                        origin = mainBullet.position
                        mainBullet.removeFromParent()
                        self.addChild(backGroundBullet)
                        bulletsLeftLabel.removeFromParent()
                        createNumberOfBulletsLabel()
                        startBulletTimer()
                        touchIsEnabled = false
                    }
                }
            }
        }
        startedTouchOnMainBullet = false
        deletePointer()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // where the pointer is created
        // as the pointer has to be updated constantly it is created in touchesMoved
        // first -> if there is an old pointer it is deleted
        deletePointer()
        if startedTouchOnMainBullet{
            for touch in touches {
                // then we are setting up the new pointer
                let location = touch.location(in: self)
                if location.y < borderBottom.position.y {
                    let line_path:CGMutablePath = CGMutablePath()
                    line_path.move(to: mainBullet.position)
                    // we get tthe point where the line has to move to, by taking the opposite of imaginary line between the mainbullet and the location of the touch
                    // if you want to change the length of the pointer, you would have to change the two '1.5'
                    line_path.addLine(to: CGPoint(x:mainBullet.position.x - 1.5*(location.x - mainBullet.position.x), y: mainBullet.position.y - 1.5*(location.y - mainBullet.position.y)))
                    let shape = SKShapeNode()
                    shape.name = "arrow"
                    shape.path = line_path
                    shape.lineWidth = 5.0
                    shape.strokeColor = SKColor.white
                    shape.fillColor = SKColor.blue
                    shape.zPosition = 3
                    self.addChild(shape)
                }
            }
        }
    }
    
    func deletePointer() {
        // the function deleting the old pointer... don't worry, i hate myself for these unnecessary descriptions
        for node in self.children{
            if let shape = node as? SKShapeNode{
                if shape.name != nil{
                    if shape.name == "arrow"{
                        shape.removeFromParent()
                    }
                }
            }
        }
    }
}
