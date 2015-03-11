//
//  ViewController.swift
//  Doodle
//
//  Created by William Huang on 3/6/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mathIcon: UIImageView!
    @IBOutlet weak var memoryIcon: UIImageView!
    @IBOutlet weak var logicIcon: UIImageView!
    @IBOutlet weak var settingsIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.mathIcon.image = UIImage(named: "mathsymbols")
        self.memoryIcon.image = UIImage(named: "memorysymbols")
        self.logicIcon.image = UIImage(named: "logicsymbols")
        self.settingsIcon.image = UIImage(named: "settingssymbols")
        self.mathIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "mathGameTapped:"))
        self.memoryIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "memoryGameTapped:"))
        self.logicIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "logicGameTapped:"))
        self.settingsIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "settingsTapped:"))
    }
    
    func mathGameTapped(gesture: UITapGestureRecognizer){
        if gesture.state == .Ended{
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.memoryIcon.alpha = 0.0
                self.logicIcon.alpha = 0.0
                self.settingsIcon.alpha = 0.0
                self.mathIcon.center = self.view.center
                }) { (finished) -> Void in
                    self.performSegueWithIdentifier("mathSegue", sender: self)
            }
        }
    }
    
    func memoryGameTapped(gesture: UITapGestureRecognizer){
        if gesture.state == .Ended{
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.mathIcon.alpha = 0.0
                    self.logicIcon.alpha = 0.0
                    self.settingsIcon.alpha = 0.0
                    self.memoryIcon.center = self.view.center
                }) { (finished) -> Void in
                    self.performSegueWithIdentifier("memorySegue", sender: self)
                }
        }
    }
    
    func logicGameTapped(gesture: UITapGestureRecognizer){
        if gesture.state == .Ended{
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.mathIcon.alpha = 0.0
                self.memoryIcon.alpha = 0.0
                self.settingsIcon.alpha = 0.0
                self.logicIcon.center = self.view.center
                }) { (finished) -> Void in
                    self.performSegueWithIdentifier("logicSegue", sender: self)
            }
        }
    }
    
    func settingsTapped(gesture: UITapGestureRecognizer){
        if gesture.state == .Ended{
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.mathIcon.alpha = 0.0
                self.logicIcon.alpha = 0.0
                self.memoryIcon.alpha = 0.0
                self.settingsIcon.center = self.view.center
                }) { (finished) -> Void in
                    self.performSegueWithIdentifier("settingsSegue", sender: self)
            }
        }
    }
    
    @IBAction func mathBackButtonTouched(segue: UIStoryboardSegue) {
        self.memoryIcon.alpha = 1.0
        self.logicIcon.alpha = 1.0
        self.settingsIcon.alpha = 1.0
    }
    
    @IBAction func memoryBackButtonTouched(segue: UIStoryboardSegue){
        self.mathIcon.alpha = 1.0
        self.logicIcon.alpha = 1.0
        self.settingsIcon.alpha = 1.0
    }
    
    @IBAction func logicBackButtonTouched(segue: UIStoryboardSegue){
        self.memoryIcon.alpha = 1.0
        self.mathIcon.alpha = 1.0
        self.settingsIcon.alpha = 1.0
    }
    
    @IBAction func settingsBackButtonTouched(segue: UIStoryboardSegue){
        self.memoryIcon.alpha = 1.0
        self.mathIcon.alpha = 1.0
        self.logicIcon.alpha = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

