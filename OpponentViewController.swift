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
    
    var add: Bool = true
    
 
    ///////////////////////////////////////////////
    let user = PFUser.currentUser()
    
    var player: PFObject?
    
    ///////////////////////////////////////////////
    var playerRelationship = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ////????????????
        usernameOponent.text = player?.objectForKey("username") as? String
        countryOponent.text = player?.objectForKey("country") as? String
        bioOponent.text = player?.objectForKey("bio") as? String
        avatarOpponent.image = UIImage(named: (player?.objectForKey("avatar") as? String)!)//????
        winsOponent.text = String((player?.objectForKey("wins") as? NSNumber)!)
        lossesOponent.text = String((player?.objectForKey("losses") as? NSNumber)!)
        
        ///new pfquerry to see relationship with objects (saving new objects)
       
        let query = PFQuery(className: "Friends")
        query.whereKey("username", equalTo: (user?.username)!)
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
        self.addDelete.setTitle("Add", forState: .Normal)
            self.add = true //boolean to keep track of button text
            for r in results!{
                print("your friends")
                print(r.objectForKey("friend")!)
                if (self.player?.objectForKey("username") as? String == r.objectForKey("friend") as? String)//?????
                {
                    self.addDelete.setTitle("Delete", forState: .Normal)
                    self.add = false // bool to keep track of button text
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

    @IBAction func addDelete(sender: AnyObject) {
        //creates a new parse object
        if add == true
        {
            let obj = PFObject(className: "Friends")
            obj.setObject((user?.username)!, forKey: "username")
            obj.setObject((player?.objectForKey("username"))!, forKey: "friend")
            obj.saveInBackgroundWithBlock({ (success, error) in
                if error != nil
                {
                    print (error?.localizedDescription)
                }
            })
        }
        //deletes the specific parse object
        else
        {
            var query = PFQuery(className: "Friends")
            query.whereKey("username", equalTo: (user!.username)!)
            query.whereKey("friend", equalTo: (player?.objectForKey("username"))!)
            query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
                
                for r in results!
                {
                    r.deleteInBackgroundWithBlock({ (success, error) in
                        if error != nil{
                            print(error!.localizedDescription)
                        }
                    })
                }
            }
            
            query = PFQuery(className: "Friends")
            query.whereKey("username", equalTo: (player?.objectForKey("username"))!)
            query.whereKey("friend", equalTo:(user!.username)! )
            query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
                
                for r in results!
                {
                    r.deleteInBackgroundWithBlock({ (success, error) in
                        if error != nil{
                            print(error!.localizedDescription)
                        }
                    })
                }
            }

        }
        
    
    }
 ////////////////////////////////////////////////////////

    
    
    
}