//
//  FourPlayTurnOfEventsViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-05-12.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit
import AVFoundation

class FourPlayTurnOfEventsViewController: UIViewController {

    //Outlets that are represented on screen
    @IBOutlet weak var dice: UIImageView!
    @IBOutlet weak var player1Roll: UIButton!
    @IBOutlet weak var player2Roll: UIButton!
    @IBOutlet weak var player3Roll: UIButton!
    @IBOutlet weak var player4Roll: UIButton!
    
    @IBOutlet weak var player1score: UILabel!
    @IBOutlet weak var player2score: UILabel!
    @IBOutlet weak var player3score: UILabel!
    @IBOutlet weak var player4score: UILabel!
    
    
    //One audioplayer to play necessary sounds
    var audioPlayer = AVAudioPlayer()
    
    //Arrays needed to refer to assets pics
    var diceNameArr = ["DICE1B", "DICE2B", "DICE3B", "DICE4B", "DICE5B", "DICE6B"]
    var numArr = ["0", "1", "2", "3", "4", "5"]
    
    //random number generated for when dice is rolled
    var randomIndexVar1 : Int?
    
    //temp scores for the players
    var player1tempScore : Float = 0
    var player2tempScore : Float = 0
    var player3tempScore : Float = 0
    var player4tempScore : Float = 0
    
    //For how many people are in the game
    var amtOfRollsLeft : Int = 4
    
    var player1active : Bool = true
    var player2active : Bool = true
    var player3active : Bool = true
    var player4active : Bool = true
    
    
    //When the view is loaded it has to deactivate the 2nd & 3rd player roll button
    //Also launches the necessary sound for it
    override func viewDidLoad() {
        super.viewDidLoad()

        
        player2Roll.isEnabled = false
        player3Roll.isEnabled = false
        player4Roll.isEnabled = false
        player2Roll.isHidden = true
        player3Roll.isHidden = true
        player4Roll.isHidden = true
        
        
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
    
    //Disables all buttons to not be pressed
    func disableRolling()
    {
        player1Roll.isEnabled = false
        player2Roll.isEnabled = false
        player3Roll.isEnabled = false
        player4Roll.isEnabled = false
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                self.player1tempScore = Float(self.player1score.text!)!
                self.player1Roll.isEnabled = false
                self.player1Roll.isHidden = true
                print(self.player1score.text!)
                
                if self.player2active == true
                {
                    self.player2Roll.isEnabled = true
                    self.player2Roll.isHidden = false
                }
                    
                else if self.player2active == false && self.player3active == true
                {
                    self.player3Roll.isEnabled = true
                    self.player3Roll.isHidden = false
                }
                
                else if self.player2active == false && self.player3active == false && self.player4active == true
                {
                    self.player4Roll.isEnabled = true
                    self.player4Roll.isHidden = false
                }
                
        }
            self.player1active = false
            self.amtOfRollsLeft = self.amtOfRollsLeft - 1
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
                    self.player2tempScore = Float(self.player2score.text!)!
                    self.player2Roll.isEnabled = false
                    self.player2Roll.isHidden = true
                    print(self.player2score.text!)
                
                    if self.player3active == true
                    {
                        self.player3Roll.isEnabled = true
                        self.player3Roll.isHidden = false
                    }
                
                    if self.player3active == false && self.player4active == true
                    {
                        self.player4Roll.isEnabled = true
                        self.player4Roll.isHidden = false
                    }
            }
        
            player2active = false
            amtOfRollsLeft = amtOfRollsLeft - 1
            
            //Checking to see who won after the last player has rolled
            //Only will be done if theres a tie between player 1 and 2
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.9)
            {
                self.nextScreen()
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
                self.player3tempScore = Float(self.player3score.text!)!
                self.player3Roll.isEnabled = false
                self.player3Roll.isHidden = true
                print(self.player3score.text!)
                
                if self.player4active == true
                {
                    self.player4Roll.isEnabled = true
                    self.player4Roll.isHidden = false
                }
            }
            
            player3active = false
            amtOfRollsLeft = amtOfRollsLeft - 1
            
            //Checking to see who won after the last player has rolled
            //This will be called if the last player is 3rd player
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.9)
            {
                self.nextScreen()
            }
        }
     
    }
    
    
     //Sequence of things that happen when player4Roll is pressed, necessary delays included
    @IBAction func p4rollPressed(_ sender: UIButton)
    {
        audioPlayer.play()
        randomImageFirst()
        if player4active == true
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)
            {
                self.diceRoll()
                self.player4score.text = String(self.randomIndexVar1! + 1)
                self.player4tempScore = Float(self.player4score.text!)!
                self.player4Roll.isEnabled = false
                self.player4Roll.isHidden = true
                self.amtOfRollsLeft = self.amtOfRollsLeft - 1
                print(self.player4score.text!)
            }
            player4active = false
            //Checking to see who won after the last player has rolled
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.9)
            {
                self.nextScreen()
            }
        }
    }
    
    func resetTempScores()
    {
        player1tempScore = 0.1
        player2tempScore = 0.2
        player3tempScore = 0.3
        player4tempScore = 0.4
        randomIndexVar1 = 0
    
    }
    
    func resetEverything()
    {
        resetTempScores()
        player1score.text = "0"
        player2score.text = "0"
        player3score.text = "0"
        player4score.text = "0"
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player2active = true
        player3active = true
        player4active = true
        amtOfRollsLeft = 4
    }

    //Resets scores and other various attributes if there is a tie with player 1, 2, 3
    func resetEverythingP1nP2nP3()
    {
        resetTempScores()
        player1score.text = "0"
        player2score.text = "0"
        player3score.text = "0"
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player2active = true
        player3active = true
        amtOfRollsLeft = 3
    }

    //Resets scores and other various attributes if there is a tie with player 1, 2, 4
    func resetEverythingP1nP2nP4()
    {
        resetTempScores()
        player1score.text = "0"
        player2score.text = "0"
        player4score.text = "0"
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player2active = true
        player4active = true
        amtOfRollsLeft = 3
    }

    //Resets scores and other various attributes if there is a tie with player 1, 3, 4
    func resetEverythingP1nP3nP4()
    {
        resetTempScores()
        player1score.text = "0"
        player3score.text = "0"
        player4score.text = "0"
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player3active = true
        player4active = true
        amtOfRollsLeft = 3
    }

    //Resets scores and other various attributes if there is a tie with player 2, 3, 4
    //n
    func resetEverythingP2nP3nP4()
    {
        resetTempScores()
        player2score.text = "0"
        player3score.text = "0"
        player4score.text = "0"
        player2Roll.isEnabled = true
        player2Roll.isHidden = false
        player2active = true
        player3active = true
        player4active = true
        amtOfRollsLeft = 3
    }



    //Resets scores and other various attributes if there is a tie with player 1, 2
    func resetEverythingP1nP2()
    {
        resetTempScores()
        player1score.text = "0"
        player2score.text = "0"
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player2active = true
        amtOfRollsLeft = 2
    }

    //Resets scores and other various attributes if there is a tie with player 1, 3
    func resetEverythingP1nP3()
    {
        resetTempScores()
        player1score.text = "0"
        player3score.text = "0"
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player3active = true
        amtOfRollsLeft = 2
    }
    //Resets scores and other various attributes if there is a tie with player 1, 4
    func resetEverythingP1nP4()
    {
        resetTempScores()
        player1score.text = "0"
        player4score.text = "0"
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player4active = true
        amtOfRollsLeft = 2
    }

    //Resets scores and other various attributes if there is a tie with player 2, 3
    func resetEverythingP2nP3()
    {
        resetTempScores()
        player2score.text = "0"
        player3score.text = "0"
        player2Roll.isEnabled = true
        player2Roll.isHidden = false
        player2active = true
        player3active = true
        amtOfRollsLeft = 2
    }

    //Resets scores and other various attributes if there is a tie with player 2, 4
    func resetEverythingP2nP4()
    {
        resetTempScores()
        player2score.text = "0"
        player4score.text = "0"
        player2Roll.isEnabled = true
        player2Roll.isHidden = false
        player2active = true
        player4active = true
        amtOfRollsLeft = 2
    }

    //Resets scores and other various attributes if there is a tie with player 3, 4
    func resetEverythingP3nP4()
    {
        resetTempScores()
        player3score.text = "0"
        player4score.text = "0"
        player3Roll.isEnabled = true
        player3Roll.isHidden = false
        player3active = true
        player4active = true
        amtOfRollsLeft = 2
    }
    
    
    //Checks to see which player will go when based on the current rolls done
    //Alert controller with action shown in either instance
    func nextScreen()
    {
        if(amtOfRollsLeft == 0)
        {
            //When a player has won
            if(player1tempScore > player2tempScore && player2tempScore > player3tempScore && player3tempScore > player4tempScore
                || player1tempScore > player2tempScore && player2tempScore > player4tempScore && player4tempScore > player3tempScore
                || player1tempScore > player3tempScore && player3tempScore > player2tempScore && player2tempScore > player4tempScore
                || player1tempScore > player3tempScore && player3tempScore > player4tempScore && player4tempScore > player2tempScore
                || player1tempScore > player4tempScore && player4tempScore > player2tempScore && player2tempScore > player3tempScore
                || player1tempScore > player4tempScore && player4tempScore > player3tempScore && player3tempScore > player2tempScore
                || player2tempScore > player1tempScore && player1tempScore > player3tempScore && player3tempScore > player4tempScore
                || player2tempScore > player1tempScore && player1tempScore > player4tempScore && player4tempScore > player3tempScore
                || player2tempScore > player3tempScore && player3tempScore > player1tempScore && player1tempScore > player4tempScore
                || player2tempScore > player3tempScore && player3tempScore > player4tempScore && player4tempScore > player1tempScore
                || player2tempScore > player4tempScore && player4tempScore > player1tempScore && player1tempScore > player3tempScore
                || player2tempScore > player4tempScore && player4tempScore > player3tempScore && player3tempScore > player1tempScore
                || player3tempScore > player1tempScore && player1tempScore > player2tempScore && player2tempScore > player4tempScore
                || player3tempScore > player1tempScore && player1tempScore > player4tempScore && player4tempScore > player2tempScore
                || player3tempScore > player2tempScore && player2tempScore > player1tempScore && player1tempScore > player4tempScore
                || player3tempScore > player2tempScore && player2tempScore > player4tempScore && player4tempScore > player1tempScore
                || player3tempScore > player4tempScore && player4tempScore > player2tempScore && player2tempScore > player1tempScore
                || player3tempScore > player4tempScore && player4tempScore > player2tempScore && player2tempScore > player1tempScore
                || player4tempScore > player1tempScore && player1tempScore > player2tempScore && player2tempScore > player3tempScore
                || player4tempScore > player1tempScore && player1tempScore > player3tempScore && player3tempScore > player2tempScore
                || player4tempScore > player2tempScore && player2tempScore > player1tempScore && player1tempScore > player3tempScore
                || player4tempScore > player2tempScore && player2tempScore > player3tempScore && player3tempScore > player1tempScore
                || player4tempScore > player3tempScore && player3tempScore > player2tempScore && player2tempScore > player1tempScore
                || player4tempScore > player3tempScore && player3tempScore > player1tempScore && player1tempScore > player2tempScore
                )
    {
            let alertController = UIAlertController(title: "Turns are set", message: "Based on the dice roll from highest number to lowest number is the order of turns if any ties amongst players, then decide amongst yourselves who goes when", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
                self.performSegue(withIdentifier: "moveToGame", sender: self)
            }
        
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
                
        //Two way tie happens twice
        else if (player1tempScore == player2tempScore && player3tempScore == player4tempScore ||
                player1tempScore == player3tempScore && player2tempScore == player4tempScore ||
                player1tempScore == player4tempScore && player2tempScore == player3tempScore)
            {
                let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was 2 ties and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
                
                let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
                    self.resetEverything()
                }
                
                alertController2.addAction(action2)
                self.present(alertController2, animated: true, completion: nil)
            }
        
                
        //If there is 4-way tie
        else if (player1tempScore == player2tempScore && player2tempScore == player3tempScore && player3tempScore == player4tempScore)
        {
            let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
            
            let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
                self.resetEverything()
            }
            
            alertController2.addAction(action2)
            self.present(alertController2, animated: true, completion: nil)
        }
        
        //If there is a three way tie between 1, 2, 3
       else if (player2tempScore == player3tempScore && player2tempScore == player1tempScore)
       {
        let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
            self.resetEverythingP1nP2nP3()
        }
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
        
        //tie between 1, 2, 4
       else if (player2tempScore == player4tempScore && player2tempScore == player1tempScore)
       {
        let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
            self.resetEverythingP1nP2nP4()
        }
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
    
        //tie between 1, 3, 4
       else if (player3tempScore == player4tempScore && player3tempScore == player1tempScore)
       {
        let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
            self.resetEverythingP1nP3nP4()
        }
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
        
       //tie between 2, 3, 4
       else if (player2tempScore == player3tempScore && player2tempScore == player4tempScore)
       {
        let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
            self.resetEverythingP2nP3nP4()
        }
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
        
        //if player 1 and 2 tie
        else if(player1tempScore == player2tempScore)
        {
            let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
        
            let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
            self.resetEverythingP1nP2()
            }
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
        
        //if player 1 and 3 tie
       else if(player1tempScore == player3tempScore)
       {
        let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
            self.resetEverythingP1nP3()
        }
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
        
        //if player 1 and 4 tie
       else if(player1tempScore == player4tempScore)
       {
        let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
            self.resetEverythingP1nP4()
        }
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
        
        //if player 2 and 3 tie
       else if(player2tempScore == player3tempScore)
       {
        let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
            self.resetEverythingP2nP3()
        }
        
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
        
        //if player 2 and 4 tie
       else if(player2tempScore == player4tempScore)
       {
        let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
            self.resetEverythingP2nP4()
        }
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
        
        //if player 3 and 4 tie
       else if(player3tempScore == player4tempScore)
       {
        let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
        
        let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
            self.resetEverythingP3nP4()
        }
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
        
        
    
    
        }
    
    }
    
 

}
