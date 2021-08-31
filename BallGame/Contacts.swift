//
//  Contacts.swift
//  bbtan
//
//  Created by Schmit Yanis on 20/03/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        // gets called every time 2 nodes get to touch eachother
        
        // these are the bodys which collided
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        // with all these disgusting if statements we have to check which nodes collided
        // to check that, you can either use the categoryBitMask (PhysicsCategory) or their name
        if (firstBody.node?.name == "borderBottom" && secondBody.categoryBitMask == PhysicsCategory.Bullet){
            secondBody.node?.physicsBody?.restitution = 1.0
            secondBody.isDynamic = false
            if isFirstBulletTouchingBottom{
                // we have to check wheter it is the first bullet because it stays on the place where it collided with the border
                mainBullet.removeFromParent()
                mainBullet.position = (secondBody.node?.position)!
                mainBullet.position.y = borderBottom.position.y + mainBullet.frame.height / 2 + 5
                self.addChild(mainBullet)
                secondBody.node?.removeFromParent()
                isFirstBulletTouchingBottom = false
                checkIfRoundIsOver()
            }else{
                // if it is not the first bullet, we are animate it so that it goes to the first bullet
                let moveDown = SKAction.moveTo(y: borderBottom.position.y + (secondBody.node?.frame.height)! / 2, duration: 0.2)
                secondBody.node?.run(moveDown)
                let moveToCenter = SKAction.moveTo(x: mainBullet.position.x, duration: 0.4)
                let remove = SKAction.removeFromParent()
                let check = SKAction.run(checkIfRoundIsOver)
                let moveAndRemove = SKAction.sequence([moveToCenter, remove, check])
                secondBody.node?.run(moveAndRemove)
                checkIfRoundIsOver()
            }
        }else if (firstBody.categoryBitMask == PhysicsCategory.Bullet && secondBody.node?.name == "borderBottom") {
            // same if statement as obove but vice-versa
            if isFirstBulletTouchingBottom{
                mainBullet.removeFromParent()
                mainBullet.position = (firstBody.node?.position)!
                mainBullet.position.y = borderBottom.position.y + mainBullet.frame.height + 5
                self.addChild(mainBullet)
                secondBody.node?.removeFromParent()
                isFirstBulletTouchingBottom = true
                checkIfRoundIsOver()
            }else{
                firstBody.isDynamic = false
                firstBody.node?.physicsBody?.restitution = 1.0
                let moveDown = SKAction.moveTo(y: borderBottom.position.y + (secondBody.node?.frame.height)! / 2, duration: 0.2)
                firstBody.node?.run(moveDown)
                let moveToCenter = SKAction.moveTo(x: mainBullet.position.x, duration: 0.4)
                let remove = SKAction.removeFromParent()
                let check = SKAction.run(checkIfRoundIsOver)
                let moveAndRemove = SKAction.sequence([moveToCenter, remove, check])
                firstBody.node?.run(moveAndRemove)
                checkIfRoundIsOver()
            }
        }else if (firstBody.categoryBitMask == PhysicsCategory.Bullet && secondBody.categoryBitMask == PhysicsCategory.Box){
            // checking if a bullet collided with a box
            for index in (0..<labelArray.count){
                // getting the label of the box the bullet collided with
                let label = labelArray[index]
                if (secondBody.node?.contains(label.position))!{
                    // changing it text to new value
                    label.text = "\(Int(label.name!)! - 1)"
                    if Int(label.text!)! < 1{
                        label.removeFromParent()
                    }
                }
            }
            if let node = secondBody.node as? SKSpriteNode as? Box{
                // reducing the hitpoints of the collided box by one
                node.hitpoints -= 1
                if node.hitpoints < 1{
                    node.removeFromParent()
                }
            }
            
        }else if (secondBody.categoryBitMask == PhysicsCategory.Bullet && firstBody.categoryBitMask == PhysicsCategory.Box) {
            // same as above, again -> vice versa
            for index in (0..<labelArray.count){
                let label = labelArray[index]
                if let node = firstBody.node{
                    if node.contains(label.position){
                        label.text = "\(Int(label.text!)! - 1)"
                        if Int(label.text!)! < 1{
                            label.removeFromParent()
                        }
                    }
                }
            }
            if let node = firstBody.node as? SKSpriteNode as? Box{
                node.hitpoints -= 1
                if node.hitpoints < 1{
                    node.removeFromParent()
                }
            }
        }else if (firstBody.categoryBitMask == PhysicsCategory.Bullet && secondBody.node?.name == "borderLeft"){
            // algorithm to detect if a bullet is flying horizontally -> prevention from a never ending game
            for child in self.children{
                if let bullet = child as? Bullet{
                    // if you want the algorithm to be less strict change the numbers 100 to a smaller number
                    if bullet.previousYPostition <= bullet.position.y + self.frame.height / 100 && bullet.previousYPostition >= bullet.position.y - self.frame.height / 100{
                        bullet.samePositionCount += 1
//                        print("here2")
//                        print(bullet.samePositionCount)
                        if bullet.samePositionCount > 6{
                            bullet.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
                            bullet.samePositionCount = 0
                        }
                    }
                }
            }
            if let bullet = firstBody.node as? Bullet{
                bullet.previousYPostition = bullet.position.y
            }

        }else if (firstBody.node?.name == "borderLeft" && secondBody.categoryBitMask == PhysicsCategory.Bullet){
            // algorithm to detect if a bullet is flying horizontally -> prevention from a never ending game
            for child in self.children{
                if let bullet = child as? Bullet{
                    // if you want the algorithm to be less strict change the numbers 100 to a smaller number
                    if bullet.previousYPostition <= bullet.position.y + self.frame.height / 100 && bullet.previousYPostition >= bullet.position.y - self.frame.height / 100{
                        bullet.samePositionCount += 1
//                        print("here2")
//                        print(bullet.samePositionCount)
                        if bullet.samePositionCount > 6{
                            bullet.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
                            bullet.samePositionCount = 0
                        }
                    }
                }
            }
            if let bullet = secondBody.node as? Bullet{
                bullet.previousYPostition = bullet.position.y
            }
        }
    }
}
