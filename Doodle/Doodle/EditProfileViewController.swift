//
//  EditProfileViewController.swift
//  Doodle
//
//  Created by William Huang on 3/13/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    var nameTextFieldStartValue: String!
    var ageTextFieldStartValue: String!
    var bioTextViewStartValue: String!
    
    override func viewDidLoad() {
        self.nameTextField.delegate = self
        self.ageTextField.delegate = self
        self.bioTextView.delegate = self
        self.nameTextField.text = nameTextFieldStartValue!
        self.ageTextField.text = ageTextFieldStartValue!
        self.bioTextView.text = bioTextViewStartValue!
    }

    @IBAction func saveInfo(sender: UIBarButtonItem) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(nameTextField.text, forKey: "name")
        defaults.setValue(ageTextField.text, forKey: "age")
        defaults.setValue(bioTextView.text, forKey: "bio")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.view.frame.origin.y -= 120.0
        self.view.frame.size.height += 120.0
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.view.frame.origin.y += 120.0
        self.view.frame.size.height -= 120.0
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}
