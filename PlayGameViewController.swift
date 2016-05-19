//
//  PlayGameViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 4/11/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController{
    @IBOutlet weak var numCards: UILabel!
    @IBOutlet weak var UserCard: UIImageView!
    @IBOutlet weak var OpponentCard: UIImageView!
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var playLable: UILabel!
    
    let user = PFUser.currentUser()
    
    var opponentPoint = Int()
    var userPoint = Int()
    
    var war = false
    var doubleWar = false
    var tripleWar = false
    var quadrupleWar = false
    //////////////////quit button////////////////
    @IBAction func onQuit(sender: AnyObject) {
        
        user?.incrementKey("losses", byAmount: 1)
        user?.saveInBackground()
        
    }
    /////////////end of quit button///////////////
    
    /// set up deck of cards////////////////
    var deckArray: [String] = ["emperor8Black", "emperor8Blue", "emperor8Pink", "emperor8Red", "king7Black", "king7Blue", "king7Pink", "king7Red", "queen6Black", "queen6Blue", "queen6Pink", "queen6Red", "princess5Black", "princess5Blue", "princess5Pink", "princess5Red", "nobleman4Black", "nobleman4Blue", "nobleman4Pink", "nobleman4Red", "knight3Black", "knight3Blue", "knight3Pink", "knight3Red", "merchant2Black", "merchant2Blue", "merchant2Pink", "merchant2Red", "peasant1Black", "peasant1Blue", "peasant1Pink", "peasant1Red"]
    var userArray = [Int]()
    var userCards = [String]()
    var opponentArray = [Int]()
    var opponentCards = [String]()
    ////////////////end of setting up deck of cards//////////////////////////
    
    ///////////////setting up game////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.currentUser()
        usernameLable.text = user?.username
        
        //set up array of unique numbers for user//
        while userArray.count < 16{
            let randomUserNumber = Int(arc4random_uniform(32))
            var found = false
            
            for index in 0 ..< userArray.count {
                if userArray[index] == randomUserNumber {
                    found = true
                    break
                }
            }
             //add numbers to user's deck//
            if found == false {
                userArray.append(randomUserNumber)
            }
        }
        //dump(userArray)
        
        //change the numbers into card names for user's deck//
        for index in 0...15{
            userCards.append(deckArray[userArray[index]])
        }
        //dump(userCards)
        
        //rest of the numbers in new array//
        while opponentArray.count < 16 {
            let randomOpponentNumber = Int(arc4random_uniform(32))
            var foundAgain = false
            for j in 0 ... 15{
                if randomOpponentNumber == userArray[j]{
                    foundAgain = true
                    break
                }
                for index in 0 ..< opponentArray.count{
                    if opponentArray[index] == randomOpponentNumber{
                        foundAgain = true
                        break
                    }
                }
                
            }
            //add numbers to opponent's deck//
            if foundAgain == false
            {
                opponentArray.append(randomOpponentNumber)
            }
            
        }
        //dump(opponentArray)
        
        //change the numbers into card names for opponents's deck//
        for index in 0...15{
            opponentCards.append(deckArray[opponentArray[index]])
        }
        //dump(opponentCards)
        
      numCards.text = String(userCards.count) /// number of cards in user's deck
    }
    ////////////////end of setting up game///////////////
    
    ////////////////play game//////////////////////////////
    @IBAction func onDeck(sender: AnyObject)
    {
        var userCard = String()
        var opponentCard = String()
        
        ////////war///////////////
        if war == true
        {
            war = true
            
            if userCards.count < 4
            {
                playLable.text = "Not enough cards for war, you lose"
                user?.incrementKey("losses", byAmount: 1)
                delay(2.0, closure: { 
                    self.performSegueWithIdentifier("Lose", sender: nil)
                })
                
                user?.saveInBackground()
                war = false
                //break///// how do I get out of this loop??
            }
            
            else if opponentCards.count < 4
            {
                playLable.text = "Not enough cards for war, you win!"
                user?.incrementKey("wins", byAmount: 1)
                delay(2.0, closure: { 
                    self.performSegueWithIdentifier("Win", sender: nil)
                })
                
                user?.saveInBackground()
                war = false
                // break /// how do I get out of this loop??
            }
            
            else
            {
                userCard = userCards[userCards.count - 4]
                opponentCard = opponentCards[opponentCards.count - 4]
                
                UserCard.image = UIImage(named: userCards[userCards.count - 4])
                OpponentCard.image = UIImage(named: opponentCards[opponentCards.count - 4])
                    
                numCards.text = String(userCards.count)//???
                
                determinePoint(userCard, opponent: opponentCard)
                    

                    
                if userPoint > opponentPoint
                {
                    playLable.text = "You won war! You win 4 cards!"
                    
                    for i in 0 ..< 4
                    {
                        userCards.insert(userCards.last!, atIndex: 0)
                        userCards.removeLast()
                        userCards.insert(opponentCards.last!, atIndex: 0)
                        opponentCards.removeLast()
                    }
                    
                    //dump(opponentCards)
            
                    
                    // check if opponent has 0 then add win to user
                    // show you won screen
                    if opponentCards.count == 0
                    {
                        //////?????????
                        user?.incrementKey("wins", byAmount: 1)
                        delay(2.0, closure: {
                            self.performSegueWithIdentifier("Win", sender: nil)
                        })
                        user?.saveInBackground()
                    }
                }
                    
                else if userPoint < opponentPoint
                {
                    playLable.text = "You lost war. You lose 4 cards."
                    for i in 0 ..< 4
                    {
                        opponentCards.insert(opponentCards.last!, atIndex: 0)
                        opponentCards.removeLast()
                        opponentCards.insert(userCards.last!, atIndex: 0)
                        userCards.removeLast()
                    }
                    
                    //dump(userCards)
                    
                    // check if user has 0 then add loss to user
                    // pop up you won and some exit button
                    if userCards.count == 0
                    {
                        user?.incrementKey("losses", byAmount: 1)
                        delay(2.0, closure: {
                            self.performSegueWithIdentifier("Lose", sender: nil)
                        })
                        user?.saveInBackground()
                    }
                }
                else
                {
                    doubleWar = true
                    war = false
                    playLable.text = "Double War!!"
                }
                    
            }
            war = false
        }
        /////////end of war//////////////////
            
            
        ////////////double war////////////////
        else if doubleWar == true
        {
            if userCards.count < 7
            {
                playLable.text = "Not enough cards for double war, you lose"
                user?.incrementKey("losses", byAmount: 1)
                delay(2.0, closure: {
                    self.performSegueWithIdentifier("Lose", sender: nil)
                })
                user?.saveInBackground()
            }
                
            else if opponentCards.count < 7
            {
                playLable.text = "Not enough cards for double war, you win!"
                user?.incrementKey("wins", byAmount: 1)
                delay(2.0, closure: {
                    self.performSegueWithIdentifier("Win", sender: nil)
                })
                user?.saveInBackground()
            }
                
            else
            {
                
                userCard = userCards[userCards.count - 7]
                opponentCard = opponentCards[opponentCards.count - 7]
                
                UserCard.image = UIImage(named: userCards[userCards.count - 7])
                OpponentCard.image = UIImage(named: opponentCards[opponentCards.count - 7])
                
                numCards.text = String(userCards.count)//???
                
                determinePoint(userCard, opponent: opponentCard)
                
                
                
                if userPoint > opponentPoint
                {
                    playLable.text = "You won double war! You win 7 cards!"
                    for i in 0 ..< 7
                    {
                        userCards.insert(userCards.last!, atIndex: 0)
                        userCards.removeLast()
                        userCards.insert(opponentCards.last!, atIndex: 0)
                        opponentCards.removeLast()
                    }
                    
                    //dump(opponentCards)
                    
                    if opponentCards.count == 0
                    {
                        user?.incrementKey("wins", byAmount: 1)
                        delay(2.0, closure: {
                            self.performSegueWithIdentifier("Win", sender: nil)
                        })
                        user?.saveInBackground()
                    }
                }
                    
                else if userPoint < opponentPoint
                {
                    playLable.text = "You lost double war. You lose 7 cards."
                    for i in 0 ..< 7
                    {
                        opponentCards.insert(opponentCards.last!, atIndex: 0)
                        opponentCards.removeLast()
                        opponentCards.insert(userCards.last!, atIndex: 0)
                        userCards.removeLast()
                    }
                    
                    //dump(userCards)
                    
                    if userCards.count == 0
                    {
                        
                        user?.incrementKey("losses", byAmount: 1)
                        delay(2.0, closure: {
                            self.performSegueWithIdentifier("Lose", sender: nil)
                        })
                        user?.saveInBackground()
                    }
                }
                    
                else
                {
                    war = false
                    doubleWar = false
                    tripleWar = true
                    playLable.text = "Triple War!!"
                }
                
            }
            doubleWar = false
        }
        //////////end of double war///////
            
        ///////////triple war/////////////
        else if tripleWar == true
        {
            if userCards.count < 10
            {
                playLable.text = "Not enough cards for triple war, you lose"
                user?.incrementKey("losses", byAmount: 1)
                delay(2.0, closure: {
                    self.performSegueWithIdentifier("Lose", sender: nil)
                })
                user?.saveInBackground()
            }
                
            else if opponentCards.count < 10
            {
                playLable.text = "Not enough cards for triple war, you win!"
                user?.incrementKey("wins", byAmount: 1)
                delay(2.0, closure: {
                    self.performSegueWithIdentifier("Win", sender: nil)
                })
                user?.saveInBackground()
            }
                
            else
            {
                
                userCard = userCards[userCards.count - 10]
                opponentCard = opponentCards[opponentCards.count - 10]
                
                UserCard.image = UIImage(named: userCards[userCards.count - 10])
                OpponentCard.image = UIImage(named: opponentCards[opponentCards.count - 10])
                
                numCards.text = String(userCards.count)//???
                
                determinePoint(userCard, opponent: opponentCard)
                
                
                
                if userPoint > opponentPoint
                {
                    playLable.text = "You won triple war! You win 10 cards!"
                    for i in 0 ..< 10
                    {
                        userCards.insert(userCards.last!, atIndex: 0)
                        userCards.removeLast()
                        userCards.insert(opponentCards.last!, atIndex: 0)
                        opponentCards.removeLast()
                    }
                    
                    //dump(opponentCards)
                    
                    if opponentCards.count == 0
                    {
                        user?.incrementKey("wins", byAmount: 1)
                        delay(2.0, closure: {
                            self.performSegueWithIdentifier("Win", sender: nil)
                        })
                        user?.saveInBackground()
                    }
                }
                    
                else if userPoint < opponentPoint
                {
                    playLable.text = "You lost triple war. You lose 10 cards."
                    for i in 0 ..< 10
                    {
                        opponentCards.insert(opponentCards.last!, atIndex: 0)
                        opponentCards.removeLast()
                        opponentCards.insert(userCards.last!, atIndex: 0)
                        userCards.removeLast()
                    }
                    
                    //dump(userCards)
                    
                    if userCards.count == 0
                    {
                        
                        user?.incrementKey("losses", byAmount: 1)
                        delay(2.0, closure: {
                            self.performSegueWithIdentifier("Lose", sender: nil)
                        })
                        user?.saveInBackground()
                    }
                }
                    
                else
                {
                    war = false
                    doubleWar = false
                    tripleWar = false
                    quadrupleWar = true
                }
                
            }
            tripleWar = false
        }
        //////end of triple war//////////
            
        ///////quadruple war///////////
        else if quadrupleWar == true
        {
            if userCards.count < 13
            {
                playLable.text = "Not enough cards for quadruple war, you lose"
                user?.incrementKey("losses", byAmount: 1)
                delay(2.0, closure: {
                    self.performSegueWithIdentifier("Lose", sender: nil)
                })
                user?.saveInBackground()
            }
                
            else if opponentCards.count < 13
            {
                playLable.text = "Not enough cards for quadruple war, you win!"
                user?.incrementKey("wins", byAmount: 1)
                delay(2.0, closure: {
                    self.performSegueWithIdentifier("Win", sender: nil)
                })
                user?.saveInBackground()
            }
                
            else
            {
                
                userCard = userCards[userCards.count - 13]
                opponentCard = opponentCards[opponentCards.count - 13]
                
                UserCard.image = UIImage(named: userCards[userCards.count - 13])
                OpponentCard.image = UIImage(named: opponentCards[opponentCards.count - 13])
                
                numCards.text = String(userCards.count)//???
                
                determinePoint(userCard, opponent: opponentCard)
                
                
                
                if userPoint > opponentPoint
                {
                    playLable.text = "You won quadruple war! You win 13 cards!"
                    for i in 0 ..< 13
                    {
                        userCards.insert(userCards.last!, atIndex: 0)
                        userCards.removeLast()
                        userCards.insert(opponentCards.last!, atIndex: 0)
                        opponentCards.removeLast()
                    }
                    
                    //dump(opponentCards)
                    
                    if opponentCards.count == 0
                    {
                        user?.incrementKey("wins", byAmount: 1)
                        delay(2.0, closure: {
                            self.performSegueWithIdentifier("Win", sender: nil)
                        })
                        user?.saveInBackground()
                    }
                }
                    
                else if userPoint < opponentPoint
                {
                    playLable.text = "You lost quadruple war. You lose 13 cards."
                    for i in 0 ..< 13
                    {
                        opponentCards.insert(opponentCards.last!, atIndex: 0)
                        opponentCards.removeLast()
                        opponentCards.insert(userCards.last!, atIndex: 0)
                        userCards.removeLast()
                    }
                    
                    //dump(userCards)
                    if userCards.count == 0
                    {
                        
                        user?.incrementKey("losses", byAmount: 1)
                        
                        delay(2.0, closure: {
                            self.performSegueWithIdentifier("Lose", sender: nil)
                        })
                        user?.saveInBackground()
                    }
                }
                    
                else
                {
                    war = false
                    doubleWar = false
                    tripleWar = false
                    quadrupleWar = false
                }
                
            }
            quadrupleWar = false
        }
        /////////end of quadruple war///////////

            
        /////////regular, no war////////////
        
        else
        {
            if userCards.count == 0
            {
                playLable.text = "Out of cards, you lost."
                user?.incrementKey("losses", byAmount: 1)
                delay(2.0, closure: {
                    self.performSegueWithIdentifier("Lose", sender: nil)
                })
                user?.saveInBackground()
            }
            else if opponentCards.count == 0
            {
                playLable.text = "You have all the cards, you won!"
                user?.incrementKey("wins", byAmount: 1)
                delay(2.0, closure: {
                    self.performSegueWithIdentifier("Win", sender: nil)
                })
                user?.saveInBackground()
                
            }
            
            else
            {
                userCard = userCards[userCards.count - 1]
                opponentCard = opponentCards[opponentCards.count - 1]
                
                UserCard.image = UIImage(named: userCards[userCards.count - 1])
                OpponentCard.image = UIImage(named: opponentCards[opponentCards.count - 1])
                
                numCards.text = String(userCards.count)
                
                determinePoint(userCard, opponent: opponentCard)
                
                if userPoint > opponentPoint
                {
                    playLable.text = "You win a card!"
                    userCards.insert(userCards.last!, atIndex: 0)
                    userCards.insert(opponentCards.last!, atIndex: 1)
                    userCards.removeLast()
                    opponentCards.removeLast()
                    
                    //dump(opponentCards)
                    
                    if opponentCards.count == 0
                    {
                        user?.incrementKey("wins", byAmount: 1)
                        delay(2.0, closure: {
                            self.performSegueWithIdentifier("Win", sender: nil)
                        })
                        user?.saveInBackground()
                        
                    }
                    
                    
                    
                    
                }
                else if userPoint < opponentPoint
                {
                    playLable.text = "You lose a card."
                    opponentCards.insert(opponentCards.last!, atIndex: 0)
                    opponentCards.insert(userCards.last!, atIndex: 1)
                    opponentCards.removeLast()
                    userCards.removeLast()
                    
                    //dump(userCards)
                    
                    if userCards.count == 0
                    {
                        /////?????
                        user?.incrementKey("losses", byAmount: 1)
                        delay(2.0, closure: {
                            self.performSegueWithIdentifier("Lose", sender: nil)
                        })
                        user?.saveInBackground()
                    }
                }
                else
                {
                    war = true
                    playLable.text = "WAR!"
                }
                
 
            }
            
        }
        ////////end of regular, no war//////////
       
    }
    ////////////////end of deck button///////////
    
    ////////////function to determine point based on card name////////////////

    func determinePoint(user: String, opponent: String) -> (userP: Int, opponentP: Int)
    {
        switch user {
        case "emperor8Black", "emperor8Blue", "emperor8Pink", "emperor8Red":
            userPoint = 8
            break
            
        case "king7Black", "king7Blue", "king7Pink", "king7Red":
            userPoint = 7
            break
            
        case "queen6Black", "queen6Blue", "queen6Pink", "queen6Red":
            userPoint = 6
            break
            
        case "princess5Black", "princess5Blue", "princess5Pink", "princess5Red":
            userPoint = 5
            break
            
        case "nobleman4Black", "nobleman4Blue", "nobleman4Pink", "nobleman4Red":
            userPoint = 4
            break
            
        case "knight3Black", "knight3Blue", "knight3Pink", "knight3Red":
            userPoint = 3
            break
            
        case "merchant2Black", "merchant2Blue", "merchant2Pink", "merchant2Red":
            userPoint = 2
            break
            
        case  "peasant1Black", "peasant1Blue", "peasant1Pink", "peasant1Red":
            userPoint = 1
            break
            
        default:
            userPoint = 0
        }
        
        switch opponent{
        case "emperor8Black", "emperor8Blue", "emperor8Pink", "emperor8Red":
            opponentPoint = 8
            break
            
        case "king7Black", "king7Blue", "king7Pink", "king7Red":
            opponentPoint = 7
            break
            
        case "queen6Black", "queen6Blue", "queen6Pink", "queen6Red":
            opponentPoint = 6
            break
            
        case "princess5Black", "princess5Blue", "princess5Pink", "princess5Red":
            opponentPoint = 5
            break
            
        case "nobleman4Black", "nobleman4Blue", "nobleman4Pink", "nobleman4Red":
            opponentPoint = 4
            break
            
        case "knight3Black", "knight3Blue", "knight3Pink", "knight3Red":
            opponentPoint = 3
            break
            
        case "merchant2Black", "merchant2Blue", "merchant2Pink", "merchant2Red":
            opponentPoint = 2
            break
            
        case  "peasant1Black", "peasant1Blue", "peasant1Pink", "peasant1Red":
            opponentPoint = 1
            break
            
        default:
            opponentPoint = 0
        }
        return (userPoint, opponentPoint)
    }
    
    /////////////end of point determining function/////////////////////
    
    //////////dispatch_after function///////////
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    ///////////end of dispatch_after code//////////
    
}
////////end of class//////////
