//
//  GameViewController.swift
//  bbtan
//
//  Created by Schmit Yanis on 20/03/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds

class GameViewController: UIViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                //                scene.size = view.bounds.size
                // Present the scene
                view.ignoresSiblingOrder = true
                view.presentScene(scene)
                //                 view.showsFPS = true
                //                 view.showsNodeCount = true
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
