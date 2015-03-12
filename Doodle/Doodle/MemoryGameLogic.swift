//
//  MemoryGameLogic.swift
//  Doodle
//
//  Created by William Huang on 3/11/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

protocol MemoryGameLogicDelegate: class{
    func didUpdateLevel(sender: MemoryGameLogic, newLevel: Int)
    func displayRestartAndEndOptions(sender: MemoryGameLogic)
}

class MemoryGameLogic {
    
    private var cards: [Card]
    private var level: Int
    private var flippedUpCards: [Card]
    private var cardsMatched: Int
    var delegate: MemoryGameLogicDelegate!
    
    init(cards: [Card], level: Int){
        self.cards = cards
        self.level = level
        flippedUpCards = Array<Card>()
        cardsMatched = 0
        resetCards(level)
    }
    
    func resetCards(level: Int){
        self.level = level
        flippedUpCards.removeAll()
        cardsMatched = 0
        switch level{
        case 1:
            cards[0].setCardValue(6)
            cards[1].setCardValue(5)
            cards[2].setCardValue(2)
            cards[3].setCardValue(6)
            cards[4].setCardValue(1)
            cards[5].setCardValue(5)
            cards[6].setCardValue(3)
            cards[7].setCardValue(1)
            cards[8].setCardValue(2)
            cards[9].setCardValue(4)
            cards[10].setCardValue(4)
            cards[11].setCardValue(3)
            for card in cards {
                card.setFaceDown()
            }
        case 2:
            cards[0].setCardValue(4)
            cards[1].setCardValue(3)
            cards[2].setCardValue(1)
            cards[3].setCardValue(4)
            cards[4].setCardValue(1)
            cards[5].setCardValue(2)
            cards[6].setCardValue(3)
            cards[7].setCardValue(2)
            cards[8].setCardValue(2)
            cards[9].setCardValue(3)
            cards[10].setCardValue(4)
            cards[11].setCardValue(1)
            for card in cards {
                card.setFaceDown()
            }
        case 3:
            cards[0].setCardValue(1)
            cards[1].setCardValue(1)
            cards[2].setCardValue(2)
            cards[3].setCardValue(3)
            cards[4].setCardValue(2)
            cards[5].setCardValue(1)
            cards[6].setCardValue(2)
            cards[7].setCardValue(3)
            cards[8].setCardValue(3)
            cards[9].setCardValue(1)
            cards[10].setCardValue(3)
            cards[11].setCardValue(2)
            for card in cards {
                card.setFaceDown()
            }
        default:
            break
        }
    }
    
    func flipCard(index: Int){
        var card = cards[index]
        if card.isCardFaceDown(){
            card.setFaceUp()
            flippedUpCards.append(card)
            if flippedUpCards.count == level + 1 {
                checkCards()
            }
        }
    }
    
    func checkCards(){
        var val = flippedUpCards[0].getCardValue()
        var allEqualValue = true
        for card in flippedUpCards {
            if card.getCardValue() != val {
                allEqualValue = false
            }
        }
        if allEqualValue{
            for card in flippedUpCards {
                card.setMatched()
                cardsMatched++
                if cardsMatched == cards.count && level < 3{
                    self.delegate.didUpdateLevel(self, newLevel: level + 1)
                    resetCards(level + 1)
                } else if cardsMatched == cards.count && level == 3{
                    self.delegate.displayRestartAndEndOptions(self)
                }
            }
        } else{
            for card in flippedUpCards {
                card.setFaceDown()
            }
        }
        flippedUpCards.removeAll()
    }
    
}
