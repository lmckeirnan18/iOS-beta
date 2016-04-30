//
//  SearchPlayersViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/25/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Parse

class SearchPlayers: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var playerTable: UITableView!
    @IBOutlet weak var playerSearchBar: UISearchBar!
    
    var searchResults = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return searchResults.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) //as! UITableViewCell
        let obj = searchResults[indexPath.row]
        myCell.textLabel?.text = obj.objectForKey("username") as? String
        return myCell
    }
    
    
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) // called when keyboard search button pressed
    {
        //let query = PFQuery(className: "User")
        let text = searchBar.text!
        let query = PFUser.query()!
        query.whereKey("username", equalTo: text)
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            for r in results!{
                print("you found: ")
                print(r.objectForKey("username")!)
            }
        
        
        
//        playerSearchBar.resignFirstResponder()
//        var usernameQuery = PFQuery(className: "User")
//        usernameQuery.whereKey("username", containsString: searchBar.text)
//        usernameQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
//
           if error != nil{
                let myAlert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction)
                
                self.presentViewController(myAlert, animated: true, completion: nil)
                
                return
          }
        
            if let objects = results as [PFObject]?{
                self.searchResults.removeAll(keepCapacity: false)
                
                for object in objects{
                    //let username =  object.objectForKey("username") as! String
                    self.searchResults.append(object)
                }
                
                dispatch_async(dispatch_get_main_queue()){
                    self.playerTable.reloadData()
                    self.playerSearchBar.resignFirstResponder()
                    
                }
            }
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    
        let obj = searchResults[indexPath.row]
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("OpponentViewController") as! OpponentViewController
        vc.player = obj
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) // called when cancel button pressed
    {
        playerSearchBar.resignFirstResponder()
        playerSearchBar.text = ""
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}

