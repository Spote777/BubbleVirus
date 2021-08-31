//
//  Random.swift
//  ReflexColor
//
//  Created by Schmit Yanis on 08/03/2017.
//  Copyright © 2017 Schmit Yanis. All rights reserved.
//

import Foundation

extension GameScene {
    func randomNumber(range: Range<Int>) -> Int {
        //function that gives a random number of a range of ints entered
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
}
