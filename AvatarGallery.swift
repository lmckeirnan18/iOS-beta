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
    
    @IBAction func smileyYellow(sender: AnyObject) {
        user!.setObject("smileyYellow", forKey: "avatar")
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func smileyPink(sender: AnyObject) {
        user!.setObject("smileyPink", forKey: "avatar")
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func playerPink(sender: AnyObject) {
        user!.setObject("playerPink", forKey: "avatar")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func playerYellow(sender: AnyObject) {
        user!.setObject("playerYellow", forKey: "avatar")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func playerBlue(sender: AnyObject) {
        user!.setObject("playerBlue", forKey: "avatar")
        self.dismissViewControllerAnimated(true, completion: nil)
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



//    @IBAction func onSmileyYellow(sender: AnyObject) {
//        user?.setObject("smileyYellow", forKey: "avatar") as? String
//
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }