//
//  Menu.swift
//  bbtan
//
//  Created by Schmit Yanis on 12/04/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene{
    func createMenu() {
        // setting up the correct booleans
        isInMenu = true
        isInGameOverView = false
        pauseButton.isHidden = true
        
        // showing the ad
        showHideAd()
//        showInterstitialAd()
        
        //creating the background
        backgroundMenu = SKSpriteNode(imageNamed: "background")
        backgroundMenu.size.width = self.size.width
        backgroundMenu.size.height = self.size.height
        backgroundMenu.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        backgroundMenu.scene?.scaleMode = .aspectFill
        backgroundMenu.zPosition = -1
        self.addChild(backgroundMenu)
        
        //creating the background image(lab)
        backgroundImageLab = SKSpriteNode(imageNamed: "lab")
        backgroundImageLab.size.width = self.size.width / 1
        backgroundImageLab.size.height = self.size.width / 1
        backgroundImageLab.anchorPoint = CGPoint(x: 0.5,y: 0)
        backgroundImageLab.position = CGPoint(x: 0, y: yPositionDown - self.frame.width / 14 - 8 * self.frame.width / 7)
        backgroundImageLab.scene?.scaleMode = .aspectFill
        backgroundImageLab.zPosition = 0
        backgroundImageLab.alpha = 0.8
        self.addChild(backgroundImageLab)
        
        //creating the background image
        backgroundImage = SKSpriteNode(imageNamed: "name")
        backgroundImage.size.width = self.size.width / 1.2
        backgroundImage.size.height = self.size.width / 2
        backgroundImage.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        backgroundImage.position = CGPoint(x: self.frame.width / 70, y: self.frame.height / 6)
        backgroundImage.scene?.scaleMode = .aspectFill
        backgroundImage.zPosition = 1
        self.addChild(backgroundImage)

        // creating the play/ball button
        playBackGround = SKShapeNode(rectOf: CGSize(width: self.frame.width / 3.5, height: self.frame.height / 7))
        playBackGround.fillTexture = SKTexture.init(imageNamed: "play button")
        playBackGround.position = CGPoint(x: self.frame.width / 5, y: -1.5 * playBackGround.frame.height)
        playBackGround.fillColor = SKColor.white
        playBackGround.lineWidth = 0
        playBackGround.zPosition = 1
        self.addChild(playBackGround)
        
        ballBackGround = SKShapeNode(rectOf: CGSize(width: self.frame.width / 3.5, height: self.frame.height / 7))
        ballBackGround.position = CGPoint(x: -self.frame.width / 5, y: -1.5 * ballBackGround.frame.height)
        ballBackGround.lineWidth = 0
        ballBackGround.fillTexture = SKTexture.init(imageNamed: "circle button")
        ballBackGround.fillColor = SKColor.white
        ballBackGround.zPosition = 1
        self.addChild(ballBackGround)
        
        // as many elements are used identically in the main game we can use that ones... saves time yay:)
        //createInGameMenuBottom()
        createBorder()
       
//        timeLabel.fontSize = self.frame.width / 10
//        timeLabel.fontName = "AvenirNext-Bold"
//        timeLabel.text = "MESSAGE..."
        timeLabel.isHidden = true
        
        createBouncingBullet()
        
        bounceBottom = SKSpriteNode(color: SKColor.clear, size: CGSize(width: self.frame.width , height: 0.1))
        bounceBottom.position = playBackGround.position
        bounceBottom.position.y += playBackGround.frame.height / 2
        bounceBottom.physicsBody = SKPhysicsBody(rectangleOf: bounceBottom.size)
        bounceBottom.physicsBody?.affectedByGravity = false
        bounceBottom.physicsBody?.isDynamic = false
        bounceBottom.physicsBody?.categoryBitMask = PhysicsCategory.Border
        bounceBottom.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        bounceBottom.physicsBody?.collisionBitMask = PhysicsCategory.Bullet
        bounceBottom.physicsBody?.friction = 0.0
        self.addChild(bounceBottom)
    }
    
    func createBouncingBullet() {
        // we even use the same bullet for the animation, that's what i call recycling
        showBullet()
        mainBullet.position = CGPoint(x: playBackGround.position.x + playBackGround.frame.width / 2.3, y: playBackGround.position.x + playBackGround.frame.height)
        mainBullet.physicsBody = SKPhysicsBody(circleOfRadius: mainBullet.frame.width / 2)
        mainBullet.physicsBody?.affectedByGravity = true
        mainBullet.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        mainBullet.physicsBody?.contactTestBitMask = PhysicsCategory.Border
        mainBullet.physicsBody?.collisionBitMask = PhysicsCategory.Border
        mainBullet.physicsBody?.friction = 0.0
        mainBullet.physicsBody?.restitution = 1.0
        mainBullet.physicsBody?.angularDamping = 0.0
        mainBullet.physicsBody?.linearDamping = 0.1
        mainBullet.physicsBody?.mass = 0.0564
    }
}
