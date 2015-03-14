//
//  LogicGameViewController.swift
//  Doodle
//
//  Created by William Huang on 3/6/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit
import CoreData

class LogicGameViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    @IBOutlet var logicCardCollection: [LogicCard]!
    @IBOutlet var logicCardSolutionCollection: [LogicCard]!
    private var logicGameLogic: LogicGameLogic!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        addGestureRecognizers()
        startNewGame()
    }
    
    func addGestureRecognizers(){
        for logicCard in logicCardCollection {
            logicCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "answerPanned:"))
        }
    }
    
    @IBAction func newGame() {
        
        if levelLabel.text == "Level: 2"{
            let logicGameHistory = NSEntityDescription.insertNewObjectForEntityForName("LogicGameHistory", inManagedObjectContext: managedObjectContext!) as LogicGameHistory
            logicGameHistory.timeStamp = NSDate()
            logicGameHistory.levelsCompleted = 1
            managedObjectContext?.save(nil)
        }
        startNewGame()
    }
    
    func startNewGame(){
        logicGameLogic = LogicGameLogic(cornerCards: logicCardSolutionCollection, userCards: logicCardCollection, level: 1)
        levelLabel.text = "Level: 1"
        categoryLabel.text = "Shape"
    }
    
    func answerPanned(gesture: UIPanGestureRecognizer){
        if gesture.state == UIGestureRecognizerState.Changed {
            self.view.bringSubviewToFront(gesture.view!)
            gesture.view?.center = gesture.locationInView(self.view)
            if let v = gesture.view {
                for solutionView in logicCardSolutionCollection {
                    if CGRectIntersectsRect(v.frame, solutionView.frame) {
                        if (v as LogicCard).getMatched() == false && logicGameLogic.checkAnswer(v as LogicCard, category: solutionView){
                            (v as LogicCard).setMatched()
                            v.hidden = true
                            if logicGameLogic.getNumberCorrect() == 5 && logicGameLogic.getLevel() == 2 {
                                self.displayRestartAndEndOptions()
                            } else if logicGameLogic.getNumberCorrect() == 5 && logicGameLogic.getLevel() == 1 {
                                self.didUpdateLevel(2)
                            }
                        }
                    }
                }
            }
        }
        if gesture.state == UIGestureRecognizerState.Ended {
            if let answerCard = gesture.view {
                UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    answerCard.center = self.view.center
                }, completion: nil)
            }
        }
    }
    
    func didUpdateLevel(newLevel: Int) {
        var alert = UIAlertController(title: "Next Level!", message: "Continue?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(
            title: "Yes", style: .Default, handler: { (act) -> Void in }
        ))
        self.presentViewController(alert, animated: true, completion: {
            self.logicGameLogic = LogicGameLogic(cornerCards: self.logicCardSolutionCollection, userCards: self.logicCardCollection, level: newLevel)
            self.levelLabel.text = "Level: \(newLevel)"
            switch newLevel {
            case 1:
                self.categoryLabel.text = "Shape"
            case 2:
                self.categoryLabel.text = "Color"
            default:
                self.categoryLabel.text = "Shape"
            }
        })
    }
    
    func displayRestartAndEndOptions() {
        let logicGameHistory = NSEntityDescription.insertNewObjectForEntityForName("LogicGameHistory", inManagedObjectContext: managedObjectContext!) as LogicGameHistory
        logicGameHistory.timeStamp = NSDate()
        logicGameHistory.levelsCompleted = 2
        managedObjectContext?.save(nil)
        
        var alert = UIAlertController(title: "You Won!", message: "Restart Game?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(
            title: "Yes", style: .Default, handler: { (act) -> Void in
                self.startNewGame()
            }
            ))
        alert.addAction(UIAlertAction(
            title: "No", style: .Default, handler: { (act) -> Void in
                self.levelLabel.text = "Level: 1"
                self.performSegueWithIdentifier("exitLogicGame", sender: self)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "exitLogicGame" {
            if levelLabel.text == "Level: 2"{
                let logicGameHistory = NSEntityDescription.insertNewObjectForEntityForName("LogicGameHistory", inManagedObjectContext: managedObjectContext!) as LogicGameHistory
                logicGameHistory.timeStamp = NSDate()
                logicGameHistory.levelsCompleted = 1
                managedObjectContext?.save(nil)
            }
        }
    }
}
