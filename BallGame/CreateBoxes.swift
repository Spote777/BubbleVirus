//
//  CreateBoxes.swift
//  bbtan
//
//  Created by Schmit Yanis on 20/03/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    class Box : SKSpriteNode {
        var hitpoints = 1
        var hasMovedDown = 1       // each time a round is over and a box moves down this one gets increased by 1
    }
    
    func createBoxes() {
        //main body of game -> creating boxes:)
        wave += 1
        numberOfBullets += 1
        xPosition = -self.frame.width / 2 + self.frame.width / 14
        
        // getting the random color for the boxes of the row
        let randomIndex = randomNumber(range: 1..<7)
        let randomColor = colorDictionary[randomIndex]!
//        print(randomColor)

        for _ in 1..<8 {
            if randomNumber(range: 0..<2) == 0 {
                // this basically gives a random true or false (0 or 1)
                // if one -> no box is created
                xPosition += self.frame.width / 7
            }else{
                // if two -> a box is created
                // the outer box is what you see(the border), the inner box makes e smaller black square
            
                let box = Box(texture: SKTexture(imageNamed: "VIRUS"),color: randomColor, size: CGSize(width: self.frame.width / 6.7, height: self.frame.width / 6.7))
                box.colorBlendFactor = 1
                
                box.position = CGPoint(x: xPosition, y: yPositionUp - box.frame.height / 2)
                box.hitpoints = wave

                box.name = "outerBox"
//                box.
                // the zPosition defines the layer on which the node exists
                // e.g if to nodes have the same position and size, their zPosition decides which one is shown
                box.zPosition = 1
                // Physics Body : every node we want to interact with another node has to get a physicsbody
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.categoryBitMask = PhysicsCategory.Box

                // the category of the node itsself
                box.physicsBody?.categoryBitMask = PhysicsCategory.Box
                // the category of the nodes we want to get informed when they collide with this node (function in Contacts.swift gets called)
                box.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
                // the category of the nodes we want to collide with this node
                box.physicsBody?.collisionBitMask = PhysicsCategory.Bullet
                // saying if we want the node to be affected by gravity ( if yes it falls down)
                box.physicsBody?.affectedByGravity = false
                // if the node is dynamic it moves on collision
                box.physicsBody?.isDynamic = false
                // how much energy gets lost on contacts with other nodes
                box.physicsBody?.friction = 0
                // hte 'bounciness' of the node
                box.physicsBody?.restitution = 1.0
                
                createBoxLabel()
                
                self.addChild(box)

            }
        }
        for node in self.children {
            // moving down all the boxes of the game after each round
            if let box = node as? Box {
                // checking if there is one or more boxes which touched the game -> if yes gameover:(
                if box.name == "outerBox" || box.name == "innerBox" {
                    box.hasMovedDown += 1
                }
                // setting up the action so that the boxes move down and then a function is called to check whether the game is over or not
                let moveDown = SKAction.moveTo(y: node.position.y - self.frame.width / 7, duration: 0.8)
                let checkIfGameOver = SKAction.run(checkIfGameIsOver)
                let moveDownCheck = SKAction.sequence([moveDown, checkIfGameOver])
                box.run(moveDownCheck)
            }
            
            if let label = node as? SKLabelNode{
                // moving down only the labels of a box 
                if let _ = Int(label.name!){
                    let moveDown = SKAction.moveTo(y: node.position.y - self.frame.width / 7, duration: 0.8)
                    label.run(moveDown)
                }
            }
        }
    }
    
    func createBoxLabel() {
        // creating the labels in the boxes
        let boxLabel = SKLabelNode(text: "\(wave)")
        boxLabel.color = UIColor.blue
        boxLabel.fontSize = 25
        boxLabel.fontName = "AvenirNext-Bold"
        boxLabel.position = CGPoint(x: xPosition , y: yPositionUp - self.frame.width / 14 - (boxLabel.frame.height / 2))
        boxLabel.zPosition = 3
        boxLabel.name = "\(wave)"

        xPosition += self.frame.width / 7
        
        self.addChild(boxLabel)
        labelArray.append(boxLabel)
    }
}





















