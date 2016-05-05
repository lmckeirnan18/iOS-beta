//
//  LoginViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/14/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func onGo(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) in
          
            if (error != nil)
            {
                print(error?.localizedDescription)
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                print("sorry you had an error")
            }
            else
            {
               ////  self.storyboard. //// pass in identifier Go into segway from UIStoryboard
                self.performSegueWithIdentifier("Go", sender: nil)
            }

        })
        

    }
    
}


//user?.setObject("test", forKey: "avatar")
//user!.saveInBackgroundWithBlock { (succes, error) in
//    var _ = 0
//}