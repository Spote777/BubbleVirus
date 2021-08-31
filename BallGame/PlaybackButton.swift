//
//  PlaybackButton.swift
//  PlaybackButton
//
//  Created by Yuji Hato on 1/1/16.
//  Copyright © 2016 dekatotoro. All rights reserved.
//


import UIKit

@objc public enum PlaybackButtonState : Int {
    case none = 0
    case pausing
    case playing
    case pending
    
    public var value: CGFloat {
        switch self {
        case .none:
            return 0.0
        case .pausing:
            return 1.0
        case .playing:
            return 0.0
        case .pending:
            return 1.0
        }
    }
    
//    public func color(_ layer: PlaybackLayer) -> UIImage {
//        switch self {
//        case .none:
//            return UIImage(named: "")!
//        case .pausing:
//            return UIImage(named: "pausing")!
//        case .playing:
//            return UIImage(named: "playing")!
//        case .pending:
//            return UIImage(named: "pending")!
//        }
//    }
}

@objc open class PlaybackLayer: CALayer {
    
    fileprivate static let kAnimationKey = "playbackValue"
    fileprivate static let kAnimationIdentifier = "playbackLayerAnimation"
    
    open var adjustMarginValue: CGFloat = 0
    open var contentEdgeInsets = UIEdgeInsets.zero
    open var buttonState = PlaybackButtonState.pausing
    open var playbackValue: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    open var playbackAnimationDuration: CFTimeInterval = PlaybackButton.kDefaultDuration
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        if let playbackLayer = layer as? PlaybackLayer {
            self.adjustMarginValue = playbackLayer.adjustMarginValue
            self.contentEdgeInsets = playbackLayer.contentEdgeInsets
            self.buttonState = playbackLayer.buttonState
            self.playbackValue = playbackLayer.playbackValue
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        self.removeAllAnimations()
    }
    
    open func setButtonState(_ buttonState: PlaybackButtonState, animated: Bool) {
        if self.buttonState == buttonState {
            return
        }
        self.buttonState = buttonState
        
        if animated {
            if self.animation(forKey: PlaybackLayer.kAnimationIdentifier) != nil {
                self.removeAnimation(forKey: PlaybackLayer.kAnimationIdentifier)
            }
            
            let fromValue: CGFloat = self.playbackValue
            let toValue: CGFloat = buttonState.value
            
            let animation = CABasicAnimation(keyPath: PlaybackLayer.kAnimationKey)
            animation.fromValue = fromValue
            animation.toValue = toValue
            animation.duration = self.playbackAnimationDuration
            animation.isRemovedOnCompletion = true
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.delegate = self
            self.add(animation, forKey: PlaybackLayer.kAnimationIdentifier)
        } else {
            self.playbackValue = buttonState.value
        }
    }
    
    open override class func needsDisplay(forKey key: String) -> Bool {
        if key == PlaybackLayer.kAnimationKey {
            return true
        }
        return CALayer.needsDisplay(forKey: key)
    }
}

extension PlaybackLayer: CAAnimationDelegate {
    
    open func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if self.animation(forKey: PlaybackLayer.kAnimationIdentifier) != nil {
                self.removeAnimation(forKey: PlaybackLayer.kAnimationIdentifier)
            }
            if let toValue : CGFloat = anim.value(forKey: "toValue") as? CGFloat {
                self.playbackValue = toValue
            }
        }
    }
}

@objc open class PlaybackButton : UIButton {
    
    static let kDefaultDuration: CFTimeInterval = 0.10
    open var playbackLayer: PlaybackLayer?
    open var duration: CFTimeInterval = PlaybackButton.kDefaultDuration {
        didSet {
            self.playbackLayer?.playbackAnimationDuration = self.duration
        }
    }
    
    open var buttonState: PlaybackButtonState {
        return self.playbackLayer?.buttonState ?? PlaybackButtonState.pausing
    }

    open override var contentEdgeInsets: UIEdgeInsets {
        didSet {
            self.playbackLayer?.contentEdgeInsets = self.contentEdgeInsets
        }
    }
    
    open var adjustMargin: CGFloat = 1 {
        didSet {
            self.playbackLayer?.adjustMarginValue = self.adjustMargin
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addPlaybackLayer()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addPlaybackLayer()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    open func setButtonState(_ buttonState: PlaybackButtonState, animated: Bool) {
        self.playbackLayer?.setButtonState(buttonState, animated: animated)
    }
    
    fileprivate func addPlaybackLayer() {
        let playbackLayer = PlaybackLayer()
        playbackLayer.frame = self.bounds
        playbackLayer.adjustMarginValue = self.adjustMargin
        playbackLayer.contentEdgeInsets = self.contentEdgeInsets
        playbackLayer.playbackValue = PlaybackButtonState.pausing.value
        playbackLayer.playbackAnimationDuration = self.duration
        self.playbackLayer = playbackLayer
        self.layer.addSublayer(playbackLayer)
    }
}
