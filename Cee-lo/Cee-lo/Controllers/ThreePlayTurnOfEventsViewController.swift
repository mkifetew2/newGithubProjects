//
//  ThreePlayTurnOfEventsViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-05-12.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit
import AVFoundation

class ThreePlayTurnOfEventsViewController: UIViewController {

    //One audioplayer to play necessary sounds
    var audioPlayer = AVAudioPlayer()
    
    //Outlets that are represented on screen
    @IBOutlet weak var dice: UIImageView!
    
    @IBOutlet weak var player1Roll: UIButton!
    @IBOutlet weak var player2Roll: UIButton!
    @IBOutlet weak var player3Roll: UIButton!
    
    
    @IBOutlet weak var player1score: UILabel!
    @IBOutlet weak var player2score: UILabel!
    @IBOutlet weak var player3score: UILabel!
    
    //Arrays needed to refer to assets pics
    var diceNameArr = ["DICE1B", "DICE2B", "DICE3B", "DICE4B", "DICE5B", "DICE6B"]
    var numArr = ["0", "1", "2", "3", "4", "5"]
    
    //random number generated for when dice is rolled
    var randomIndexVar1 : Int?
    
    //temp scores for the players
    var player1tempScore : Int = 0
    var player2tempScore : Int = 0
    var player3tempScore : Int = 0
    
    //For how many people are in the game
    var amtOfRollsLeft : Int = 3
    
    var player1active : Bool = true
    var player2active : Bool = true
    var player3active : Bool = true

    
    //When the view is loaded it has to deactivate the 2nd & 3rd player roll button
    //Also launches the necessary sound for it
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player2Roll.isEnabled = false
        player2Roll.isHidden = true
        player3Roll.isEnabled = false
        player3Roll.isHidden = true
        
        //Do-catch necessary for sounds to be included
        
        let sound = Bundle.main.path(forResource: "diceRollingSound", ofType: "mp3")
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
        catch
        {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Disables all buttons to not be pressed
    func disableRolling()
    {
        player1Roll.isHidden = true
        player2Roll.isHidden = true
        player3Roll.isHidden = true
    }
    
    //Changes the on-screen dice
    func changeImage()
    {
        dice.image = UIImage(named: self.diceNameArr[Int(arc4random_uniform(UInt32(self.diceNameArr.count)))])
    }
    
    
    //Responsible for the dice changing images on screen when button is pressed
    //Necessary delays included to look nice on screen
    func randomImageFirst()
    {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2)
        {
            self.changeImage()
            self.disableRolling()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4)
        {
            self.changeImage()
            self.disableRolling()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)
        {
            self.changeImage()
            self.disableRolling()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8)
        {
            self.changeImage()
            self.disableRolling()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
        {
            self.changeImage()
            self.disableRolling()
        }
        
        
    }
    
    //Function that is called when player presses their roll button
    func diceRoll()
    {
        disableRolling()
        let randomNum = numArr[Int(arc4random_uniform(UInt32(diceNameArr.count)))]
        
        let startIndex = randomNum[randomNum.startIndex]
        
        if let number1 = Int(String(startIndex))
        {
            randomIndexVar1 = number1
        }
        UIUpdates()
    }
    
    //Updates the on-screen dice
    func UIUpdates()
    {
      dice.image = UIImage(named: diceNameArr[randomIndexVar1!])
    }
    
    //Sequence of things that happen when player1Roll is pressed, necessary delays included
    @IBAction func p1rollPressed(_ sender: UIButton)
    {
        audioPlayer.play()
        randomImageFirst()
        if player1active == true
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.diceRoll()
                self.player1score.text = String(self.randomIndexVar1! + 1)
                self.player1tempScore = Int(self.player1score.text!)!
                self.player1Roll.isEnabled = false
                self.player1Roll.isHidden = true
        
                if self.player2active == true
            {
                self.player2Roll.isEnabled = true
                self.player2Roll.isHidden = false
            }
            
                if self.player2active == false && self.player3active == true
            {
                self.player3Roll.isEnabled = true
                self.player3Roll.isHidden = false
            }
        }
            
        player1active = true
        amtOfRollsLeft = amtOfRollsLeft - 1
        }
    }
    
    //Sequence of things that happen when player2Roll is pressed, necessary delays included
    @IBAction func p2rollPressed(_ sender: UIButton)
    {
        audioPlayer.play()
        randomImageFirst()
        if player2active == true
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)
            {
                self.diceRoll()
                self.player2score.text = String(self.randomIndexVar1! + 1)
                self.player2tempScore = Int(self.player2score.text!)!
                self.player2Roll.isEnabled = false
                self.player2Roll.isHidden = true
                
                if self.player3active == true
                {
                    self.player3Roll.isEnabled = true
                    self.player3Roll.isHidden = false
                }
            }
        
        player2active = false
        amtOfRollsLeft = amtOfRollsLeft - 1
        
            //Checking to see who won after the last player has rolled
            //Only will be done if theres a tie between player 1 and 2
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.9)
            {
                self.checkForPlayOrder()
            }
        }
    }
    
    
    //Sequence of things that happen when player3Roll is pressed, necessary delays included
    @IBAction func p3rollPressed(_ sender: UIButton)
    {
        audioPlayer.play()
        randomImageFirst()
        if player3active == true
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)
            {
                self.diceRoll()
                self.player3score.text = String(self.randomIndexVar1! + 1)
                self.player3tempScore = Int(self.player3score.text!)!
                self.player3Roll.isEnabled = false
                self.player3Roll.isHidden = true
                self.amtOfRollsLeft = self.amtOfRollsLeft - 1
            }
        }
        
        //Checking to see who won after the last player has rolled
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.9)
        {
            self.checkForPlayOrder()
        }
        player3active = false
    }
    
   
    //Refactored function for resetting necessary on screen elements 
    func reset(whichPlayers : String)
    {
        player1tempScore = 0
        player2tempScore = 0
        player3tempScore = 0
        randomIndexVar1 = 0
        
        //Resets scores and other various attributes if there is a tie with player 1 and 2
        if (whichPlayers == "P1nP2")
        {
            player1active = true
            player2active = true
            player1score.text = "0"
            player2score.text = "0"
            player1Roll.isEnabled = true
            player1Roll.isHidden = false
        }
        //Resets scores and other various attributes if there is a tie with player 1 and 3
        else if (whichPlayers == "P1nP3")
        {
            player1active = true
            player3active = true
            player1score.text = "0"
            player3score.text = "0"
            player1Roll.isEnabled = true
            player1Roll.isHidden = false
        }
         //Resets scores and other various attributes if there is a tie with player 2 and 3
        else if (whichPlayers == "P2nP3")
        {
            player2active = true
            player3active = true
            player2score.text = "0"
            player3score.text = "0"
            player2Roll.isEnabled = true
            player2Roll.isHidden = false
        }
            
        //Resets scores and other various attributes if there is a 3-way tie
        else if (whichPlayers == "all")
        {
            player1active = true
            player2active = true
            player3active = true
            player1score.text = "0"
            player2score.text = "0"
            player3score.text = "0"
            player1Roll.isEnabled = true
            player1Roll.isHidden = false
        }
        
    }
    
    //Checks to see which player will go when based on the current rolls done
    //Alert controller with action shown in either instance
    func checkForPlayOrder()
    {
        if(amtOfRollsLeft == 0)
        {
        
        //When a player has won
        if(player1tempScore > player2tempScore && player2tempScore > player3tempScore
            || player1tempScore > player3tempScore && player3tempScore > player2tempScore
            || player2tempScore > player3tempScore && player3tempScore > player1tempScore
            || player2tempScore > player1tempScore && player1tempScore > player3tempScore
            || player3tempScore > player1tempScore && player1tempScore > player2tempScore
            || player3tempScore > player2tempScore && player2tempScore > player1tempScore)
        {
            let alertController = UIAlertController(title: "Turns are set", message: "Based on the dice roll from highest number to lowest number is the order of turns for the next screen " , preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
                self.performSegue(withIdentifier: "moveToGame", sender: self)
            }
            
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
            
        //When all three rollers are tied
        else if (player2tempScore == player3tempScore && player2tempScore == player1tempScore)
        {
            let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
            
            let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
                self.reset(whichPlayers: "all")
            }
            
            amtOfRollsLeft = 3
            
            alertController2.addAction(action2)
            self.present(alertController2, animated: true, completion: nil)
        }
         
        
        //When the first roller and second roller are tied
        else if (player1tempScore == player2tempScore)
        {
            let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
            
            let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
                self.reset(whichPlayers: "P1nP2")
            }
            amtOfRollsLeft = 2
            
            alertController2.addAction(action2)
            self.present(alertController2, animated: true, completion: nil)
        }
        
        
        //When the first and third roller are tied
        else if (player1tempScore == player3tempScore)
        {
            let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
            
            let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
                self.reset(whichPlayers: "P1nP3")
            }
            
            amtOfRollsLeft = 2
            
            alertController2.addAction(action2)
            self.present(alertController2, animated: true, completion: nil)
        }
        
        
        //When the second and third roller are tied
        else if (player2tempScore == player3tempScore)
        {
            let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
            
            let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
                self.reset(whichPlayers: "P2nP3")
            }
            
            amtOfRollsLeft = 2
            
            alertController2.addAction(action2)
            self.present(alertController2, animated: true, completion: nil)
        }
        
        
        }
    }
   
}
