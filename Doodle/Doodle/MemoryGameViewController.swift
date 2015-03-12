//
//  MemoryGameViewController.swift
//  Doodle
//
//  Created by William Huang on 3/6/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class MemoryGameViewController: UIViewController, MemoryGameLogicDelegate {
    
    @IBOutlet var cards: [Card]!
    @IBOutlet weak var levelLabel: UILabel!
    private var memoryGameLogic: MemoryGameLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.newGame()
    }
    
    @IBAction func newGame() {
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
        self.levelLabel.text = "Level: \(newLevel)"
    }
    
    func displayRestartAndEndOptions(sender: MemoryGameLogic){
        var alert = UIAlertController(title: "You Won!", message: "Restart Game?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(
            title: "Yes", style: .Default, handler: { (act) -> Void in
                self.newGame()
            }
        ))
        alert.addAction(UIAlertAction(
            title: "No", style: .Default, handler: { (act) -> Void in
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
    
}
