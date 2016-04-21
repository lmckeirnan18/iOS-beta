//
//  EditAccount.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/11/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class EditAccountViewController: UIViewController {
    //???????????????
    //@IBOutlet weak var username: UILabel! = PFUser.currentUser()?.username
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var bio: UITextField!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var losses: UILabel!
   
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBAction func onSave(sender: AnyObject) {
        let user = PFUser.currentUser()
        user?.setObject(self.country.text!, forKey: "country")
        user?.setObject(self.bio.text!, forKey: "bio")
        //user?.setObject("test", forKey: "avatar")
        
        user!.saveInBackgroundWithBlock { (succes, error) in
                    var _ = 0
        }
    }
   
    override func viewDidLoad(){
        super.viewDidLoad()
        let user = PFUser.currentUser()
        username.text = user?.username
        avatar.image = UIImage(named: (user?.objectForKey("avatar") as? String)!)
        country.text = user?.objectForKey("country") as? String
        bio.text = user?.objectForKey("bio") as? String
        //////??????????
        wins.text = user?.objectForKey("wins") as? String
        losses.text = user?.objectForKey("losses") as? String
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
}
