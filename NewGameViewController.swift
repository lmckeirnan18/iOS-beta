//
//  NewGameViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/11/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {
    
    @IBOutlet weak var username: UILabel!
    
    let user = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.currentUser()
        username.text = user?.username
    }
    
    
    
    
}
