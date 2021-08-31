//
//  GameScene.swift
//  bbtan
//
//  Created by Schmit Yanis on 20/03/2017.
//  Copyright © 2017 Relor. All rights reserved.
//

import SpriteKit
import GameplayKit
import GoogleMobileAds

struct PhysicsCategory {
    // each of these 4 nodes get a category so that we can check later on which nodes collided (this is done in the contacts file)
    static let Box : UInt32 = 0x1 << 1
    static let Bullet : UInt32 = 0x1 << 2
    static let Border : UInt32 = 0x1 << 3
    static let PCircle : UInt32 = 0x1 << 4
}

class GameScene: SKScene, SKPhysicsContactDelegate , GADFullScreenContentDelegate, GADBannerViewDelegate {
    // background
    var backgroundMenu = SKSpriteNode()
    var backgroundGame = SKSpriteNode()
    var backgroundImage = SKSpriteNode()
    var backgroundImageLab = SKSpriteNode()
    
    // the ads
    var bannerView : GADBannerView!
    var rewardedAd : GADRewardedAd?
    var interstitial : GADInterstitialAd?
    
    //colors
    var colorDictionary = [Int : SKColor]()      // get the random colors for the boxes from this dictionary, it gets initialzed right below in the view did load
    var randomColor = SKColor()                  // after a random color is chosen, it is set into this variable, so that it can be accessed
    
    //positions
    var xPosition = CGFloat()                    // the x position of the first box for each round
    var yPositionUp = CGFloat()                  // a fixed y position to base the boxes y position an the upper border y position on
    var yPositionDown = CGFloat()                // again a fixed y position to base the balls and the lower border y position on:)
    
    //bullets
    var numberOfBullets = Int()                   // the number of balls the user can shoot in each round
    var bulletsShot = Int()                      // the number of bullets the user has already shot
    var bulletsLeftLabel = SKLabelNode()         // the number beside the balls showing how many balls are left to shoot
    var bulletLocation = CGPoint()               // used to know where the bullets are going to fly
    var origin = CGPoint()                       // used to know where the bullets are starting from
    var mainBullet = SKShapeNode()               // the bullet which stays always at the bottom to show the shoot position
    var backGroundBullet = SKShapeNode()         // the bullet which shows where the bullets are starting from
    var bulletSize = CGFloat()                   // the size of the bullets, can be changed by clicking on the ballbutton in the menu
    var bulletColor = SKColor()                  // you'll get this one, i believe in you
    
    // timer
    var timeLeftMin = Int()                      // the minutes left -> used in the countdown at the bottom of the game
    var timeLeftSec = Int()                      // the seconds left
    
    // score
    var wave = Int()                             // basically the round/score -> each time the player gets to shoot again it increases by one
    var highscore = Int()                        // hmmm... what could that possibly be?:)
    var savedHighscore : Int? = UserDefaults.standard.object(forKey: "highscore") as! Int? // the highscore that got saved in core data
    
    // booleans
    var roundOver = Bool()                       // is set to true when all balls have left the gamefield
    var touchIsEnabled = Bool()                  // touch is disabled for show while there are still balls left in the current round
    var startedTouchOnMainBullet = Bool()        // the user needs to start the touch on the mainbullet first to give it an impulse
    var isFirstBulletTouchingBottom = Bool()     // needed because the first bullet `landing` determines the position from where on the user will shoot next
    public var isInMenu = Bool()                        // is set to true if user is in menu and set to false when not... quite obvious:)
    var isInGameOverView = Bool()                // the view the user gets to decide wheter to get one more chance or to stop
    var gameOver = Bool()                         // if yes -> nno need to check for other boxes if the game is over
    
    // timers
    var bulletTimer = Timer()                    // the timer which controls the time gap bof the bullets about to be shot
    var labelTimer = Timer()                     // the timer which updates the time at the bottom in the main game
    
    
    // borders
    var borderRight = SKSpriteNode()             // ... the borders:)
    var borderLeft = SKSpriteNode()
    var borderTop = SKSpriteNode()
    var borderBottom = SKSpriteNode()
    
    // ingame menu
    var menuRect = SKShapeNode()                // the base for the puase and help button in the main game
    var pauseButton = PlaybackButton() // ehhhmmm... a pause button?:) declared in PlaybackButton.swift
    var scoreLabel = SKLabelNode()              // the label in the main game showing the current score
    var highscoreLabel = SKLabelNode()          // the label in the main game showing the highscore
    var bestLabel = SKSpriteNode()               // the label in the main game above the highscore saying "BEST" ... that explanation though
    var timeRect = SKShapeNode()                // the border of the timer at the bottom
    var timeLabel = SKLabelNode()               // the label which shows the time at the bottom
    
    // menu
    var playBackGround = SKShapeNode()          // the red/pruple background of the play button
    var ballBackGround = SKShapeNode()          // same but for the ball button
    var triangleShape = SKShapeNode()           // the cute triangle representing the play button
    var circleShape = SKShapeNode()             // the circle representing the buton to change the ball .. wow even the names are more descriptive than the description

    var bouncingBall = SKSpriteNode()           // the ball which seems to bounce on the play button
    var bounceBottom = SKSpriteNode()           // the node which the ball is actually bouncing
    
    //gameOverView
    var quitButton = SKShapeNode()              // the button to quit the game and go back to the main menu
    var watchVideoButton = SKShapeNode()        // the button to watch a video and therefore get one more chance
    var darkerBackgroundRect = SKShapeNode()    // a rect that stretches over the whole screen with alpha < 1 to make the background seem darker
    var continueLabel = SKLabelNode()           // the label which says Continue? ... wow that imagination involved
    var endGameLabel = SKLabelNode()            // i do not dare describing this one anymore...
    var oneMoreLabel = SKLabelNode()            // well...ehhh...pfff
    var chanceLabel = SKLabelNode()             // i had to put them into to different lines:)
    
    var endGameImage = SKSpriteNode()
    var oneMoreChanceImage = SKSpriteNode()
    
    // other
    var labelArray = [SKLabelNode]()             // this array contains all labels which show the hitpoints of the boxes
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        bulletSize = self.frame.width / 35
        
        xPosition = -self.frame.width  / 2 + self.frame.width / 14
        yPositionUp = self.frame.height / 2 - self.frame.height / 5 +  self.frame.width / 7
        yPositionDown = self.frame.height / 2 - self.frame.height / 5 + self.frame.width / 14
        
        bulletColor = SKColor.white
        
        colorDictionary = [
            1 : UIColor(red: 42/255, green: 172/255, blue: 102/255, alpha: 1.0),
            2 : UIColor(red: 73/255, green: 237/255, blue: 145/255, alpha: 1.0),
            3 : UIColor(red: 45/255, green: 100/255, blue: 69/255, alpha: 1.0),
            4 : UIColor(red: 19/255, green: 111/255, blue: 204/255, alpha: 1.0),
            5 : UIColor(red: 194/255, green: 187/255, blue: 0/255, alpha: 1.0),
            6 : UIColor.red
        ]
//        
        // setting up the banner ad
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        let request = GADRequest()
        //GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["2077ef9a63d2b398840261c8221a0c9b"]
        bannerView.adUnitID = "ca-app-pub-9389537920189357/3989795139"
        bannerView.rootViewController = self.view?.window?.rootViewController
        bannerView.load(request)
        
        // preloading the interstitial
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-9389537920189357/9761830715",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                              }
            )
        
        // preloading the video ad
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-9389537920189357/5427478818",
                                  request: request, completionHandler: { (ad, error) in
                                    if let error = error {
                                      print("Rewarded ad failed to load with error: \(error.localizedDescription)")
                                      return
                                    }
                                    self.rewardedAd = ad
                                    self.rewardedAd?.fullScreenContentDelegate = self
                                  }
          )
//        
//        // the pause button is created only once, if no need -> pauseButton.isHidden = true (hiding it)
        loadHighScore()
        //createPauseButton()
        createMenu()
    }
}
