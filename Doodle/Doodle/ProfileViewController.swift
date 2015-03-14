//
//  ProfileViewController.swift
//  Doodle
//
//  Created by William Huang on 3/7/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        picker.delegate = self
        picker.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        bioTextView.editable = false
    }
    
    override func viewDidAppear(animated: Bool) {
        var defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.valueForKey("name") as? String{
            nameLabel.text = name
        }
        if let age = defaults.valueForKey("age") as? String{
            ageLabel.text = age
        }
        if let bio = defaults.valueForKey("bio") as? String{
            bioTextView.text = bio
        }
        if let image = defaults.valueForKey("image") as? NSData{
            let serialQ = dispatch_queue_create("imageQueue", DISPATCH_QUEUE_SERIAL)
            dispatch_async(serialQ, { () -> Void in
                var img = UIImage(data: image)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.imageView.image = img
                })
            })
        }
    }
    
    @IBAction func editImage(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.tabBarController?.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let selectedImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = selectedImage
            NSUserDefaults.standardUserDefaults().setValue(UIImagePNGRepresentation(selectedImage), forKey: "image")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editProfileSegue" {
            if let epv = segue.destinationViewController as? EditProfileViewController {
                epv.nameTextFieldStartValue = nameLabel.text
                epv.ageTextFieldStartValue = ageLabel.text
                epv.bioTextViewStartValue = bioTextView.text
            }
        }
    }
    
}
