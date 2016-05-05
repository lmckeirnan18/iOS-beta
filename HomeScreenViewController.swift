//
//  HomeScreenViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/8/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    @IBOutlet weak var username: UILabel!
    
    @IBAction func onLogout(sender: AnyObject) {
        
        PFUser.logOutInBackgroundWithBlock { (error) in
            if (error != nil)
            {
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        let user = PFUser.currentUser()
        username.text = user?.username
    }
    
    
    
    
    
}