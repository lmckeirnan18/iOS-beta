//
//  SearchViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/11/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class SearchViewController: UISearchController, UISearchBarDelegate
{

    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let d = 0
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
            }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        
        //let user = PFUser.currentUser()
    do{
        let text = searchBar.text!
        let query = PFUser.query()!
        //let results = try query.findObjects()
        //query.whereKey("username", equalTo: text) ///try pf query that uses containsString, containsPrefix... etc
        query.whereKey("username", containsString: text)
        query.findObjectsInBackgroundWithBlock { (users, error) in
            for u in users!{
                print(u.objectForKey("username")!)
                self.viewWillAppear(true)
                
            }
        }


    }
        catch{}
    }
    
    
   override func viewWillAppear(animated: Bool) {
    var x = 0;

    self.searchBar.delegate = self
    }
    
    
    

    //PFQuerry in parse to match names
    //queary with class name where key username contains whatever thye type in. 
    //whereKey: containsString
    
    //self.dismiss
    //UISearchBarDelegate
}

