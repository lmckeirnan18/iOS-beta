//
//  CurrentGamesTableViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 3/10/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class CurrentGamesTableViewController: UITableViewController {
    // MARK: Properties
    
    var currentGames = [CurrentGame]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load the sample data
        loadSampleGames()
    }
    
    func loadSampleGames() {
        let photo1 = UIImage(named: "SmileyYellow")!
        let game1 = CurrentGame(opponentName: "andantespirit", opponentPhoto: photo1)
        
        let photo2 = UIImage(named: "SmileyYellow")!
        let game2 = CurrentGame(opponentName: "charmandapanda", opponentPhoto: photo2)
        
        currentGames += [game1, game2]
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    ////////////////HELP!!!!!!!!

   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentGames.count
    }

    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Tabel view cells are reused and should be daqueued useing a cell identifier
        
        let cellIdentifier = "CurrentGamesTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CurrentGameTableViewCell
        
        // Fetches the appropriate meal for the data source layout
        
        let game = currentGames[indexPath.row]
        cell.opponentNameLabel.text = game.opponentName
        cell.opponentImageView.image = game.opponentPhoto
        
        
        return cell
    }

    
}


class CurrentGame {
    var opponentName: String
    var opponentPhoto: UIImage
    
    
    init(opponentName: String, opponentPhoto: UIImage){
        self.opponentName = opponentName
        self.opponentPhoto = opponentPhoto
        
    }
}
 