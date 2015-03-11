//
//  Card.swift
//  Doodle
//
//  Created by William Huang on 3/11/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class Card: UIView {
    
    private var value = 0
    private var isFaceDown = true
    private var cardLabel: UILabel!
    
    func setCardValue(val: Int){
        self.value = val
    }
    
    func getCardValue() -> Int{
        return value
    }
    
    func setFaceDown(){
        isFaceDown = true
        if self.cardLabel == nil {
            self.cardLabel = UILabel(frame: CGRectMake(0, 0, 40, 40))
            self.cardLabel.textColor = UIColor.blackColor()
            self.cardLabel.textAlignment = .Center
            self.cardLabel.text = "?"
            self.alpha = 0.55
        }
        setNeedsDisplay()
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.alpha = 0.55
        }) { (finished) -> Void in
            self.cardLabel.text = "?"
        }
    }
    
    func setFaceUp(){
        isFaceDown = false
        cardLabel.text = "\(value)"
        setNeedsDisplay()
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.alpha = 1.0
            
        })
    }
    
    func isCardFaceDown() -> Bool{
        return isFaceDown
    }
    
    func setMatched(){
        self.alpha = 0.25
    }
    
    override func drawRect(rect: CGRect) {
        if let label = cardLabel {
            label.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0)
            self.addSubview(label)
        }
    }
    
}
