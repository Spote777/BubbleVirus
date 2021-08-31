//
//  Share.swift
//  Relor
//
//  Created by Schmit Yanis on 26/03/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import Social
import GoogleMobileAds

extension GameScene {
    
    // everything you need to share something on facebook and/or twitter
    // if you want to use this in an other app don't forget to import Social
    
    func showShare() {
        
        // this function obviously gets called when somebody touches on the share button
        
        let alert = UIAlertController(title: "Better than your friends?", message: "Share your highscore!", preferredStyle: .actionSheet)
         // setting up the share on facebook button
        let actionFB = UIAlertAction(title: "Share on Facebook", style: .default, handler: { (action) in
            let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
            
            //post.add(UIImage(named: "Image.png"))
            
            self.view?.window?.rootViewController?.present(post, animated: true, completion: nil)
        })
        
        // setting up the share on twitter button
        let actionTwitter = UIAlertAction(title: "Share on Twitter", style: .default, handler: { (action) in
            
            let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
            
            post.setInitialText("Can you beat me on C-LONE? My highscore is \(self.highscore)!")
            //post.add(UIImage(named: "Image.png"))
            
            self.view?.window?.rootViewController?.present(post, animated: true, completion: nil)
            
            
        })
        
        // finally setting up the cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(actionFB)
        alert.addAction(actionTwitter)
        alert.addAction(cancel)
        
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
