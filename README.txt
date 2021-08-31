BALL GAME
First of all, thank you for buying my project!
As you probably recognised, this little game I developed is inspired by the game BB-TAN from 111% and Ballz from Ketchapp.
I really had fun developing my version and i hope you will have fun personalising, fine-tuning and upgrading it.
On this page I will guide you through all the necessary steps to get this app running with all it's features, e.g ads.


-Technology used:
The app is entirely written in Swift 3.0 using the game technology SpriteKit.


Prerequisites
Xcode:
I would suggest you to download the latest version of Xcode from the App Store, to be sure that everything works fine.
Once installed, make sure to select your project team team and set a bundle identifier.

Quick start guide:
If you already have downloaded Xcode, simply open the BallGame.xcworkspace file and launch the app on the simulator (clicking on the play button, top left corner). The app should launch without any errors
and the game is ready to be played.

-AdMob
To get the ads working properly you need to create an AdMob account at https://www.google.com/admob/landing/sign-up-003a.html?subid=emea-semexp3a-r3&gclid=CJWV062jqdMCFesV0wodTmgOaw.
From here, having created your own account, you need to monetise a new app (make sure to use the same bundle identifier for AdMob than the one you used for the app), where you create a banner ad, a reward video ad and an interstitial ad.
For all three you will get an ad id, which you need to copy and paste into the Ad.swift and GameScene.swift file where the placeholder "Your banner ad id”, "Your video ad id" and “Your interstitial ad id” are .
Furthermore, you will get an app id which you need to copy and paste into AppDelegate.swift where the placeholder "Your app id" is.
That's it, from now on your ads should be working fine, and if you upload your app to the App Store, you will get money on your AdMob account for every ad watched:)
If there are any questions concerning the ad you can of course contact me or have a look at the following links:
        https://www.youtube.com/watch?v=8NhZIJ5i1is&t=177s  a video tutorial for banner ads
        https://firebase.google.com/docs/admob/ios/quick-start the official tutorial from google, where you should find everything you would want to know
Things i already have to done for the ads to be displayed which may not be obvious are:
    - installing the necessary pods ('Firebase/Core', 'Firebase/AdMob')
     (if you are not familiar with pods have a look at https://cocoapods.org)
    - adding a few lines in AppDelegate.swift to configure FireBase
    - import GoogleMobileAds in the files I worked with the ads (Ad.swift, GameScene.swift, EndCreateGame.swift)
    - making the GameScene a GADAdDelegate and GADRewardBasedVideoAdDelegate


Performance
If you want to know the fps or the number of nodes in the scene, remove the comment from the two lines
        // view.showsFPS = true
        // view.showsNodeCount = true
in GameViewController.swift
Then, you can also get further information in the Debug Navigator ( 6th button at the top left) on the performance.


Personalise the app
To quickly personalise the app without changing the gameplay i would suggest you to change :
    the colors in the colorDictionary
    the bulletSize
    the bulletColor
    the labels in general
    the positioning of the different nodes


Function flow
To get a deep understanding on what concept this app is based on, I would highly suggest you to look at the photo 'FunctionFlow' in the group 'Images' in the Xcode project.
In this picture I tried to make a scheme on how the app works step by step by writing down the main functions and on how they interact with each other.
Don't blame me for my handwriting:)


Programming style :
I tried to comment all the different parts of the code, but again if have any additional questions, contact me!
If you read through the code you will probably recognise that I nearly always use self.frame.width/height to get the dimensions of nodes. (even for the font-size... maybe a little exaggerated:))
This has the advantage that everything will scale correctly, no matter on which device you run the app.
Then, nearly every variable is declared GameScene. I did this so that they are 'public' to use them later on in different functions.
Finally, we come to the structure of the code. I tried to place everything that belongs together in a file, which I then put with the according name in the group 'Extensions'.


Contact
If you have any questions, you can of course contact me!
email : relorapps@gmail.com


