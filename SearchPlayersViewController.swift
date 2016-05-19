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
    ////////////////////////search users by exact username/////////////////////////////
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        let text = searchBar.text!
        let query = PFUser.query()!
        query.whereKey("username", equalTo: text) //looking for specific username
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
            //search results
            if let objects = results as [PFObject]?{
                self.searchResults.removeAll(keepCapacity: false)
                
                for object in objects{
                    self.searchResults.append(object)
                }
                //displays results on table??
                dispatch_async(dispatch_get_main_queue()){
                    self.playerTable.reloadData()
                    self.playerSearchBar.resignFirstResponder()
                    
                }
            }
        }
    }
    
    /////////////////selecting a cell to display friend stats///////////////////
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    
        let obj = searchResults[indexPath.row]
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("OpponentViewController") as! OpponentViewController
        vc.player = obj
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    /////////////////cancle button/////////////////
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        playerSearchBar.resignFirstResponder()
        playerSearchBar.text = ""
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}

