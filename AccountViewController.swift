//
//  AccountViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 3/2/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    @IBAction func OnHome(sender: AnyObject) {
    }
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var losses: UILabel!
    
    @IBOutlet weak var avatar: UIImageView!
    
    let user = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.currentUser()
        username.text = user?.username
        country.text = user?.objectForKey("country") as? String
        bio.text = user?.objectForKey("bio") as? String
        //////?????????????????
        wins.text = String((user?.objectForKey("wins") as? NSNumber)!)
        losses.text = String((user?.objectForKey("losses") as? NSNumber)!)
        /////?????????
        avatar.image = UIImage(named: (user?.objectForKey("avatar") as? String)!)
        
    }
    
   

    //overrride func viewWillAppear{ refresh image}
    
    
}
