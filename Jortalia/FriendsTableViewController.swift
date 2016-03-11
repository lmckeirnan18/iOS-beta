//
//  FriendsTableViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 3/10/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit


class FriendsTableViewController: UITableViewController {
    //MARK: Properties
    
    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load the sample data
        loadSampleFriends()
    }
    
    func loadSampleFriends() {
        let photo1 = UIImage(named: "SmileyYellow")!
        let friend1 = Friend(name: "charmandapanda", photo: photo1, country: "United States" )
        
        let photo2 = UIImage(named: "PlayerDefault")!
        let friend2 = Friend(name: "andantespirit", photo: photo2, country: "United States")
        
        friends += [friend1, friend2]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Tabel view cells are reused and should be daqueued useing a cell identifier
        
        let cellIdentifier = "FriendsTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FriendsTableViewCell
        
        // Fetches the appropriate meal for the data source layout
        
        let friend = friends[indexPath.row]
        cell.nameLabel.text = friend.name
        cell.photoImageView.image = friend.photo
        cell.countryLabel.text = friend.country
        
        
        
        return cell
    }
}


class Friend {
    var name: String
    var photo: UIImage
    var country: String
    
    init(name: String, photo: UIImage, country: String){
        self.name = name
        self.photo = photo
        self.country = country
    }
}