//
//  MathGameLogic.swift
//  Doodle
//
//  Created by William Huang on 3/11/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

protocol MathGameLogicDelegate: class{
    func didUpdateLevel(sender: MathGameLogic, newLevel: Int)
    func displayRestartAndEndOptions(sender: MathGameLogic)
    func continueLevel(sender: MathGameLogic)
}

class MathGameLogic {
    
    private var initialVariables: [EquationVariable]
    private var answerOptions: [EquationVariable]
    private var correctAnswer = 0
    private var correctAnswersInLevel = 0
    private var level: Int
    var delegate: MathGameLogicDelegate!
    
    init(initialVariables: [EquationVariable], answerOptions: [EquationVariable], level: Int) {
        self.initialVariables = initialVariables
        self.answerOptions = answerOptions
        self.level = level
        resetVariables()
    }
    
    func resetVariables(){
        initialVariables[0].setVariableValue(Int(arc4random_uniform(10) + 1))
        initialVariables[1].setVariableValue(Int(arc4random_uniform(10) + 1))
        switch level {
        case 1:
            correctAnswer = initialVariables[0].getVariableValue() + initialVariables[1].getVariableValue()
        case 2:
            correctAnswer = initialVariables[0].getVariableValue() - initialVariables[1].getVariableValue()
        case 3:
            correctAnswer = initialVariables[0].getVariableValue() * initialVariables[1].getVariableValue()
        default:
            correctAnswer = initialVariables[0].getVariableValue() + initialVariables[1].getVariableValue()
        }
        setAnswerOptions()
    }
    
    func setAnswerOptions(){
        var combination = arc4random_uniform(3)
        switch combination {
        case 0:
            answerOptions[0].setVariableValue(correctAnswer)
            answerOptions[1].setVariableValue(correctAnswer + 1)
            answerOptions[2].setVariableValue(correctAnswer + 2)
        case 1:
            answerOptions[0].setVariableValue(correctAnswer - 1)
            answerOptions[1].setVariableValue(correctAnswer)
            answerOptions[2].setVariableValue(correctAnswer + 1)
        case 2:
            answerOptions[0].setVariableValue(correctAnswer - 2)
            answerOptions[1].setVariableValue(correctAnswer - 1)
            answerOptions[2].setVariableValue(correctAnswer)
        default:
            answerOptions[0].setVariableValue(correctAnswer)
            answerOptions[1].setVariableValue(correctAnswer + 1)
            answerOptions[2].setVariableValue(correctAnswer + 2)
        }
    }
    
    func checkAnswer(answer: Int) -> Bool{
        return correctAnswer == answer
    }
    
    func userDidSubmitCorrectAnswer(){
        correctAnswersInLevel++
        if correctAnswersInLevel < 3 {
            delegate.continueLevel(self)
        } else if level != 3 {
            delegate.didUpdateLevel(self, newLevel: level + 1)
        } else {
            delegate.displayRestartAndEndOptions(self)
        }
    }
    
}
