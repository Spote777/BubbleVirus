//
//  Ad.swift
//  bbtan
//
//  Created by Schmit Yanis on 13/04/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import Foundation
import GoogleMobileAds
import SpriteKit

extension GameScene {
    // the file you'll probably like most :)
    func showHideAd() {
        if isInMenu {
            bannerView = GADBannerView(adSize: GADAdSize(size:CGSize(width: bannerView.frame.width, height: bannerView.frame.height), flags: 1), origin: CGPoint(x: 55, y: 15))
            bannerView.contentMode = .left
            let request = GADRequest()
//            GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["2077ef9a63d2b398840261c8221a0c9b"]
            bannerView.adUnitID = "ca-app-pub-9389537920189357/3989795139"
            bannerView.rootViewController = self.view?.window?.rootViewController
            bannerView.load(request)
            self.view?.addSubview(bannerView)
            bannerView.isHidden = false
        }else {
            // if we are not in the menu the banner ad is hidden
            bannerView.isHidden = true
        }
    }
    
    func showVideoAd() {
        if let ad = rewardedAd {
            ad.present(fromRootViewController: (self.view?.window?.rootViewController)!,
                       userDidEarnRewardHandler: {
                        _ = ad.adReward
                        
                       }
            )
        } else {
            print("Ad wasn't ready")
        }
    }
    
    func showInterstitialAd() {
        if interstitial != nil {
            interstitial?.present(fromRootViewController: (self.view?.window?.rootViewController)!)
        } else {
            print("Ad wasn't ready")
        }
    }
}
