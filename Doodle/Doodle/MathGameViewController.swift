//
//  MathGameViewController.swift
//  Doodle
//
//  Created by William Huang on 3/6/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class MathGameViewController: UIViewController, MathGameLogicDelegate {
    
    
    @IBOutlet var initialVariables: [EquationVariable]!
    @IBOutlet var answerOptions: [EquationVariable]!
    private var originalCenter = CGPointMake(0, 0)
    @IBOutlet weak var levelOperator: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var resultingView: UIView!
    private var mathGameLogic: MathGameLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        addGestureRecognizers()
        self.newGame()
    }
    
    func addGestureRecognizers(){
        for answer in answerOptions {
            answer.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "answerPanned:"))
        }
    }
    
    func answerPanned(gesture: UIPanGestureRecognizer){
        if gesture.state == UIGestureRecognizerState.Began{
            if let v = gesture.view {
                originalCenter = v.center
            }
        }
        if gesture.state == UIGestureRecognizerState.Changed {
            gesture.view?.center = gesture.locationInView(self.view)
            if let v = gesture.view {
                if CGRectIntersectsRect(v.frame, resultingView.frame) {
                    if mathGameLogic.checkAnswer((v as EquationVariable).getVariableValue()){
                        v.center = self.originalCenter
                        self.mathGameLogic.userDidSubmitCorrectAnswer()
                    }
                }
            }
        }
        if gesture.state == UIGestureRecognizerState.Ended {
            gesture.view?.center = originalCenter
        }
    }
    
    @IBAction func newGame() {
        mathGameLogic = MathGameLogic(initialVariables: initialVariables, answerOptions: answerOptions, level: 1)
        mathGameLogic.delegate = self
        self.levelOperator.text = "+"
        self.levelLabel.text = "Level: 1"
    }
    
    func displayCorrectAlert(){
        var alert = UIAlertController(title: "Correct!", message: "Continue?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(
            title: "Yes", style: .Default, handler: { (act) -> Void in }
            ))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func continueLevel(sender: MathGameLogic) {
        displayCorrectAlert()
        mathGameLogic.resetVariables()
    }
    
    func didUpdateLevel(sender: MathGameLogic, newLevel: Int) {
        displayCorrectAlert()
        mathGameLogic = MathGameLogic(initialVariables: initialVariables, answerOptions: answerOptions, level: newLevel)
        mathGameLogic.delegate = self
        self.levelLabel.text = "Level: \(newLevel)"
        switch newLevel {
        case 1:
            self.levelOperator.text = "+"
        case 2:
            self.levelOperator.text = "-"
        case 3:
            self.levelOperator.text = "x"
        default:
            self.levelOperator.text = "+"
        }
    }
    
    func displayRestartAndEndOptions(sender: MathGameLogic) {
        var alert = UIAlertController(title: "You Won!", message: "Restart Game?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(
            title: "Yes", style: .Default, handler: { (act) -> Void in
                self.newGame()
            }
            ))
        alert.addAction(UIAlertAction(
            title: "No", style: .Default, handler: { (act) -> Void in
                self.performSegueWithIdentifier("exitMathGame", sender: self)
            }
            ))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
}
