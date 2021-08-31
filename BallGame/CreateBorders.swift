//
//  CreateBorders.swift
//  bbtan
//
//  Created by Schmit Yanis on 10/04/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene{
    func createBorder() {
        // creating the borders on the edges of the screen
        // if you want to see where they are, simply change their color:)
        // the borders are the holy walls which keep the bullets locked in the game, muhaaha,, ohh well, i gotta go get some help
        
        borderRight = SKSpriteNode()
        borderRight.size = CGSize(width: 3, height: self.frame.height)
        borderRight.position = CGPoint(x: self.frame.width / 2 , y: 0)
        borderRight.physicsBody = SKPhysicsBody(rectangleOf: borderRight.size)
        borderRight.physicsBody?.affectedByGravity = false
        borderRight.physicsBody?.isDynamic = false
        borderRight.physicsBody?.categoryBitMask = PhysicsCategory.Border
        borderRight.physicsBody?.collisionBitMask = 0
        borderRight.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        borderRight.physicsBody?.friction = 0.0
        borderRight.color = UIColor.black
        borderRight.name = "border"
        
        borderLeft = SKSpriteNode()
        borderLeft.size = CGSize(width: 3, height: self.frame.height)
        borderLeft.position = CGPoint(x: -self.frame.width / 2 , y: 0)
        borderLeft.physicsBody = SKPhysicsBody(rectangleOf: borderLeft.size)
        borderLeft.physicsBody?.affectedByGravity = false
        borderLeft.physicsBody?.isDynamic = false
        borderLeft.physicsBody?.categoryBitMask = PhysicsCategory.Border
        borderLeft.physicsBody?.collisionBitMask = 0
        borderLeft.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        borderLeft.physicsBody?.friction = 0.0
        borderLeft.color = UIColor.black
        borderLeft.name = "borderLeft"
        
        borderTop = SKSpriteNode()
        borderTop.size = CGSize(width: self.frame.width, height: 3)
        borderTop.position = CGPoint(x: 0, y: yPositionUp)
        borderTop.zPosition = 3
        borderTop.physicsBody = SKPhysicsBody(rectangleOf: borderTop.size)
        borderTop.physicsBody?.affectedByGravity = false
        borderTop.physicsBody?.isDynamic = false
        borderTop.physicsBody?.categoryBitMask = PhysicsCategory.Border
        borderTop.physicsBody?.collisionBitMask = 0
        borderTop.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        borderTop.physicsBody?.friction = 0.0
        borderTop.color = UIColor(white: 1, alpha: 0.5)
        borderTop.name = "border"
        
        borderBottom = SKSpriteNode()
        borderBottom.size = CGSize(width: self.frame.width, height: 3)
        borderBottom.position = CGPoint(x: 0, y: yPositionDown - self.frame.width / 14 - 8 * self.frame.width / 7)
        borderBottom.zPosition = 3
        borderBottom.physicsBody = SKPhysicsBody(rectangleOf: borderBottom.size)
        borderBottom.physicsBody?.affectedByGravity = false
        borderBottom.physicsBody?.isDynamic = false
        borderBottom.physicsBody?.categoryBitMask = PhysicsCategory.Border
        borderBottom.physicsBody?.collisionBitMask = 0
        borderBottom.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        borderBottom.physicsBody?.friction = 1.0
        borderBottom.color = UIColor(white: 1, alpha: 0.5)
        borderBottom.name = "borderBottom"
        
        self.addChild(borderTop)
        self.addChild(borderLeft)
        self.addChild(borderRight)
        self.addChild(borderBottom)
    }
}
