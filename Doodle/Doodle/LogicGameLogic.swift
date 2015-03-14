//
//  LogicGameLogic.swift
//  Doodle
//
//  Created by William Huang on 3/12/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

//protocol LogicGameLogicDelegate: class{
//    func didUpdateLevel(sender: LogicGameLogic, newLevel: Int)
//    func displayRestartAndEndOptions(sender: LogicGameLogic)
//}

class LogicGameLogic {
    
    private var cornerCards: [LogicCard]
    private var userCards: [LogicCard]
    private var level: Int
    private var numberCorrect = 0
    
    init(cornerCards: [LogicCard], userCards: [LogicCard], level: Int){
        self.cornerCards = cornerCards
        self.userCards = userCards
        self.level = level
        resetCards()
    }
    
    func resetCards(){
        cornerCards[0].setShape(0, colorVal: 0)
        cornerCards[1].setShape(1, colorVal: 1)
        cornerCards[2].setShape(2, colorVal: 2)
        for userCard in userCards {
            userCard.setShape(Int(arc4random_uniform(3)), colorVal: Int(arc4random_uniform(3)))
            if let outerView = userCard.superview {
                userCard.center = outerView.center
            }
            if let outerView = userCard.superview {
                userCard.hidden = false
            }
        }
    }
    
    func checkAnswer(userAnswer: LogicCard, category: LogicCard) -> Bool {
        switch level {
        case 1:
            if userAnswer.getShape() == category.getShape() {
                numberCorrect++
                return true
            }
            return false
        case 2:
            if userAnswer.getColor() == category.getColor() {
                numberCorrect++
                return true
            }
            return false
        default:
            return false
        }
    }
    
    func getLevel() -> Int{
        return level
    }
    
    func getNumberCorrect() -> Int{
        return numberCorrect
    }
    
}
