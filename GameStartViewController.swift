//
//  GameStartViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/11/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class GameStartViewController: UIViewController{
    
    @IBOutlet weak var username: UILabel!
    
    
    override func viewDidLoad() {
        let user = PFUser.currentUser()
        username.text = user?.username
    }
    
}
