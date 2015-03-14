//
//  MemoryGameViewController.swift
//  Doodle
//
//  Created by William Huang on 3/6/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit
import CoreData

class MemoryGameViewController: UIViewController, MemoryGameLogicDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    @IBOutlet var cards: [Card]!
    @IBOutlet weak var levelLabel: UILabel!
    private var memoryGameLogic: MemoryGameLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.startNewGame()
    }
    
    @IBAction func newGame() {
        if levelLabel.text == "Level: 2"{
            let memoryGameHistory = NSEntityDescription.insertNewObjectForEntityForName("MemoryGameHistory", inManagedObjectContext: managedObjectContext!) as MemoryGameHistory
            memoryGameHistory.timeStamp = NSDate()
            memoryGameHistory.levelsCompleted = 1
            managedObjectContext?.save(nil)
        } else if levelLabel.text == "Level: 3"{
            let memoryGameHistory = NSEntityDescription.insertNewObjectForEntityForName("MemoryGameHistory", inManagedObjectContext: managedObjectContext!) as MemoryGameHistory
            memoryGameHistory.timeStamp = NSDate()
            memoryGameHistory.levelsCompleted = 2
            managedObjectContext?.save(nil)
        }
        startNewGame()
    }
    
    func startNewGame(){
        memoryGameLogic = MemoryGameLogic(cards: cards, level: 1)
        memoryGameLogic.delegate = self
        self.levelLabel.text = "Level: 1"
    }
    
    @IBAction func cardTapped(sender: UITapGestureRecognizer) {
        var index = find(cards as [UIView], sender.view!)
        if let number = index {
            memoryGameLogic.flipCard(number)
        }
    }
    
    func didUpdateLevel(sender: MemoryGameLogic, newLevel: Int) {
        var alert = UIAlertController(title: "Next Level!", message: "Continue?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(
            title: "Yes", style: .Default, handler: { (act) -> Void in }
        ))
        self.presentViewController(alert, animated: true) { () -> Void in
            self.levelLabel.text = "Level: \(newLevel)"
            self.memoryGameLogic = MemoryGameLogic(cards: self.cards, level: newLevel)
            self.memoryGameLogic.delegate = self
        }
        
    }
    
    func displayRestartAndEndOptions(sender: MemoryGameLogic){
        let memoryGameHistory = NSEntityDescription.insertNewObjectForEntityForName("MemoryGameHistory", inManagedObjectContext: managedObjectContext!) as MemoryGameHistory
        memoryGameHistory.levelsCompleted = 3
        memoryGameHistory.timeStamp = NSDate()
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
                self.performSegueWithIdentifier("exitMemoryGame", sender: self)
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
        if segue.identifier == "exitMemoryGame" {
            if levelLabel.text == "Level: 2"{
                let memoryGameHistory = NSEntityDescription.insertNewObjectForEntityForName("MemoryGameHistory", inManagedObjectContext: managedObjectContext!) as MemoryGameHistory
                memoryGameHistory.timeStamp = NSDate()
                memoryGameHistory.levelsCompleted = 1
                managedObjectContext?.save(nil)
            } else if levelLabel.text == "Level: 3"{
                let memoryGameHistory = NSEntityDescription.insertNewObjectForEntityForName("MemoryGameHistory", inManagedObjectContext: managedObjectContext!) as MemoryGameHistory
                memoryGameHistory.timeStamp = NSDate()
                memoryGameHistory.levelsCompleted = 2
                managedObjectContext?.save(nil)
            }
        }
    }
    
}
