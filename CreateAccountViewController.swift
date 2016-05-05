//
//  CreateAccountViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/12/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController{
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var bio: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var losses: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBAction func onSave(sender: AnyObject) {
        
        let user = PFUser()
        user.username = self.username.text
        user.password = self.password.text
        user.setObject(self.country.text!, forKey: "country")
        user.setObject(self.bio.text!, forKey: "bio")
        user.setObject(0, forKey: "wins")
        user.setObject(0, forKey: "losses")
        
        user.setObject("playerBlue", forKey: "avatar")
        //user.setObject(self.avatar.image, forKey: "avatar")
    
        
        user.signUpInBackgroundWithBlock { (succes, error) in
            if error != nil
            {
                print(error?.localizedDescription)
            }
        }
        
       
      
    }
   

    

}


//        let o = PFObject(className: "test")
//        o.setObject("Hi", forKey: "text")
//        o.saveInBackgroundWithBlock { (s, e) in
//            if e != nil{
//                print(e?.localizedDescription)
//            }
//        }


// UIImage(named: String)

//object.setObject("79lilypad", forKey: "username")
//object.