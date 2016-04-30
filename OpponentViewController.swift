//
//  OpponentViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/11/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class OpponentViewController: UIViewController {
    
    @IBOutlet weak var usernameOponent: UILabel!
    @IBOutlet weak var countryOponent: UILabel!
    @IBOutlet weak var bioOponent: UILabel!
    @IBOutlet weak var avatarOpponent: UIImageView!
    @IBOutlet weak var winsOponent: UILabel!
    @IBOutlet weak var lossesOponent: UILabel!
    
    @IBOutlet weak var addDelete: UIButton!
    //??? button add or delete
    
    @IBAction func addDelete(sender: AnyObject) {
        
        
        //if for text
        //boolean for deleting and adding
        if (addDelete.titleLabel == "add"){
            let obj = PFObject(className: "Friends")
            obj.setObject((user?.username)!, forKey: "username")
            obj.setObject((player?.objectForKey("username"))!, forKey: "friend")
            obj.saveInBackgroundWithBlock({ (success, error) in
                if (error != nil)
                {
                    print(error?.localizedDescription);
                }
            })
        }
        else
        {
            player?.deleteEventually()
        }
    }
    ///////////////////////////////////////////////
    let user = PFUser.currentUser()
    
    var player: PFObject?
    ///////////////////////////////////////////////
    var playerRelationship = [PFObject]() //????????
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameOponent.text = player?.objectForKey("username") as? String
        countryOponent.text = player?.objectForKey("country") as? String
        bioOponent.text = player?.objectForKey("bio") as? String
        avatarOpponent.image = UIImage(named: (player?.objectForKey("avatar") as? String)!)
        winsOponent.text = String((player?.objectForKey("wins") as? NSNumber)!)
        lossesOponent.text = String((player?.objectForKey("losses") as? NSNumber)!)
        
        ///new pfquerry to see relationship with objects (saving new objects)
       
        let query = PFQuery(className: "Friends")
        query.whereKey("username", equalTo: (user?.username)!)
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
        self.addDelete.setTitle("Add", forState: .Normal)
            for r in results!{
                print("your friends")
                print(r.objectForKey("friend")!)
                if (self.player?.objectForKey("username") as? String == r.objectForKey("friend") as? String)//?????
                {
                    self.addDelete.setTitle("Delete", forState: .Normal)
                   
                }
               
            }
            
            if let objects = results as [PFObject]?{
                
                for object in objects{
                    self.playerRelationship.append(object)
                }
            }
        }
        
        ////////////Query
//        let query = PFQuery(className: "Friends")
//        query.findObjectsInBackgroundWithBlock { (results, error) in
//            if (error != nil)
//            {
//                print(error?.localizedDescription)
//            }
//            else
//            {
//                for obj in results!
//                {
//                    let text = obj.objectForKey("Friends")
//                    print(text!)
//                }
//            }
//        }

        
        
    }
    /////////////////////////////////////////////
    
    ///save object
    
//    let obj = PFObject(className: "Test")
//    obj.setObject("Hello There", forKey: "Text");
//    obj.saveInBackgroundWithBlock({ (success, error) in
//    if (error != nil)
//    {
//    print(error?.localizedDescription);
//    }
//    });
//
  
    
    
    
    
    /////////////////////////////////////

    
    
    
    
    
    
    
}