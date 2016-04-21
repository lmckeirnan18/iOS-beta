//
//  AvatarGallery.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/11/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class AvatarGallery: UIViewController {
    
    let user = PFUser.currentUser()
    
    @IBOutlet weak var smileyYellow: UIButton!
    @IBOutlet weak var smileyPink: UIButton!
    
    
    
    
    
    @IBAction func onSmileyYellow(sender: AnyObject) {
        user?.setObject("smileyYellow", forKey: "avatar") as? String
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func smileyYellow(sender: AnyObject) {
        user?.setObject("smileyYellow", forKey: "avatar") as? String
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func smileyPink(sender: AnyObject) {
    }
    
    @IBAction func playerPink(sender: AnyObject) {
    }
    @IBAction func playerYellow(sender: AnyObject) {
    }
    @IBAction func playerBlue(sender: AnyObject) {
    }
    
    
    
    //    @IBAction func smileyYellow(sender: AnyObject) {
//        let user = PFUser.currentUser()
//        user?.setObject(self.avatar.string
//            , forKey: "avatar")
//    }
//    
//    @IBAction func smileyPink(sender: AnyObject) {
//    }
    
    //UIImage(string)
    //self.dissmiss on a button
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}
