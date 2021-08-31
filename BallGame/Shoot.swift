//
//  Shoot.swift
//  bbtan
//
//  Created by Schmit Yanis on 20/03/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene{
    
    class Bullet : SKShapeNode{
        var previousYPostition = CGFloat(0)
        var samePositionCount = 0
    }
    
    func showBullet() {
        // this is the bullet which you see bouncing in the menu
        // and the bullet which you see in the main game lying on the bottom, doing nothing but sunbathing, between the rounds
        mainBullet = SKShapeNode(circleOfRadius: bulletSize)
        mainBullet.fillTexture = SKTexture(imageNamed:"PROJECTILE")
        mainBullet.fillColor = .white
//        mainBullet.strokeColor = bulletColor
        mainBullet.position = CGPoint(x: 0, y: borderBottom.position.y + mainBullet.frame.height / 2 + 5)
        mainBullet.zPosition = 4
        mainBullet.name = "mainBullet"
        origin = mainBullet.position
        self.addChild(mainBullet)
        
    }
    
    @objc func shootBullets() {
        // checking if there are bullets left to be shot
        if bulletsShot < numberOfBullets{
            if numberOfBullets - bulletsShot > 0 {
                // updating the bulletsLeftLabel
                bulletsLeftLabel.text = "\(numberOfBullets - bulletsShot)"
            }else {
                // if there are no bullets left, the bulletsLeftLabel is deleted
                bulletsLeftLabel.removeFromParent()
            }
            // every 0.2 seconds the bulletTimer creates this bullet below
            let bullet = Bullet(circleOfRadius: bulletSize)
            bullet.fillTexture = SKTexture(imageNamed:"PROJECTILE")
            bullet.fillColor = .white
            //bullet.strokeColor = bulletColor
            bullet.position = backGroundBullet.position
            bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.frame.height / 2)
            bullet.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
            bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Box | PhysicsCategory.Border | PhysicsCategory.PCircle
            bullet.physicsBody?.collisionBitMask = PhysicsCategory.Box | PhysicsCategory.Border | PhysicsCategory.PCircle
            bullet.physicsBody?.affectedByGravity = false
            bullet.physicsBody?.isDynamic = true
            bullet.physicsBody?.friction = 0
            bullet.physicsBody?.restitution = 1.0
            bullet.physicsBody?.angularDamping = 0.0
            bullet.physicsBody?.linearDamping = 0.0
            bullet.name = "bullet"
            bullet.zPosition = 3
            bullet.physicsBody?.mass = 0.0564

            self.addChild(bullet)
            
            // doing the maths to get a vector which has always the same length, but points in the right direction
            let x = bulletLocation.x - origin.x
            let y = bulletLocation.y - origin.y
            let ratio = x/y
            let newY = CGFloat(getShootSpeed(a:origin, b: bulletLocation)/(sqrt(Double(1 + (ratio * ratio)))))
            let newX = CGFloat(ratio * newY)
            
            // applying an impulse of the calculated vector to the bullet
            bullet.physicsBody?.applyImpulse(CGVector(dx: newX, dy: newY))
            bulletsShot += 1
            
        }else {
            // this gets called when the last bullet has been shot
            bulletTimer.invalidate()
            backGroundBullet.removeFromParent()
            bulletsLeftLabel.removeFromParent()
        }
    }

    
    func getShootSpeed(a: CGPoint, b: CGPoint) -> Double{
        // calculating how fast the bullet is going to fly
        // if you want to change it, i would not recommand you to try to understand my calculations, simply change the return value to e.g 200:)
        // ...and if you try to understand, don't blame me for my strange thinking
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        let distance = CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
        if distance < self.frame.width / 6 {
            // if the distance is between 0 and self.frame.width / 6
            return 60
        }else if distance < self.frame.width / 4 {
            // if the distance is between self.frame.width / 6 and self.frame.width / 4
            return 75
        }else if distance < self.frame.width / 2 {
            // if the distance is between self.frame.width / 4 and self.frame.width / 2
            return 90
        }else {
            return 100
        }
    }
    
}











