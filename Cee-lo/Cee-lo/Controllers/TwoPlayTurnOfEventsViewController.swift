//
//  TwoPlayTurnOfEventsViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-05-12.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit
import AVFoundation

class TwoPlayTurnOfEventsViewController: UIViewController {

    //Two audioplayers to play necessary sounds
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    //Outlets that are represented on screen
    @IBOutlet weak var dice: UIImageView!
    @IBOutlet weak var player1Roll: UIButton!
    @IBOutlet weak var player2Roll: UIButton!
    
    @IBOutlet weak var player1score: UILabel!
    @IBOutlet weak var player2score: UILabel!
    
    
    //Arrays needed to refer to assets pics
    var diceNameArr = ["DICE1B", "DICE2B", "DICE3B", "DICE4B", "DICE5B", "DICE6B"]
    var numArr = ["0", "1", "2", "3", "4", "5"]
    
    
    //random number generated for when dice is rolled
    var randomIndexVar1 : Int?
    
    //temp scores for the players
    var player1tempScore : Int = 0
    var player2tempScore : Int = 0
    
    
    
    //When the view is loaded it has to deactivate the 2nd player roll button
    //Also launches the necessary sound for it
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player2Roll.isEnabled = false
        player2Roll.isHidden = true
        
        
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
        
        let sound2 = Bundle.main.path(forResource: "ceeloBackground", ofType: "mp3")
        do
        {
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2!))
        }
        catch
        {
            print(error)
        }
        audioPlayer2.play()
    }

 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //Disables both buttons to not be pressed
    func disableRolling()
    {
        player1Roll.isEnabled = false
        player2Roll.isEnabled = false
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
    
    //Resets the game from the beginning
    func resetEverything()
    {
        player1tempScore = 0
        player2tempScore = 0
        player1score.text = "0"
        player2score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
    }
    

    //Sequence of things that happen when player1Roll is pressed, necessary delays included
    @IBAction func p1rollPressed(_ sender: UIButton)
    {
        audioPlayer.play()
        randomImageFirst()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {

            self.diceRoll()
            //testForTieFunctionality()
            print("got here")
            self.player1score.text = String(self.randomIndexVar1! + 1)
            self.player1tempScore = Int(self.player1score.text!)!
            self.player1Roll.isEnabled = false
            self.player2Roll.isEnabled = true
            self.player1Roll.isHidden = true
            self.player2Roll.isHidden = false
        }
        
        
        
    }
    
    //Sequence of things that happen when player2Roll is pressed, necessary delays included
    @IBAction func p2rollPressed(_ sender: UIButton)
    {
        audioPlayer.play()
        randomImageFirst()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)
        {
            self.diceRoll()
            //testForTieFunctionality()
            self.player2score.text = String(self.randomIndexVar1! + 1)
            self.player2tempScore = Int(self.player2score.text!)!
            self.player2Roll.isEnabled = false
            self.player2Roll.isHidden = true
            
        }
        
        //Checking to see who won after the last player has rolled
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.9)
        {
            self.checkForPlayOrder()
        }
    }
    

 
    //Checks to see which player will go when based on the current rolls done
    //Alert controller with action shown in either instance 
    func checkForPlayOrder()
    {
        if(player1tempScore > player2tempScore || player2tempScore > player1tempScore)
        {
            let alertController = UIAlertController(title: "Turns are set", message: "Based on the dice roll from highest number to lowest number is the order of turns for the next screen" , preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
                self.performSegue(withIdentifier: "moveToGame", sender: self)
            }
            
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else if (player1tempScore == player2tempScore)
        {
            let alertController2 = UIAlertController(title: "Re-roll needs to be done", message: "There was tie and a re-roll needs to be done so that turns can be decided", preferredStyle: .alert)
            
            let action2 = UIAlertAction(title: "OK", style: .default) { (action:    UIAlertAction) in
                self.resetEverything()
            }
            
            alertController2.addAction(action2)
            self.present(alertController2, animated: true, completion: nil)
            
        
        }
    }
    
    
 

}
