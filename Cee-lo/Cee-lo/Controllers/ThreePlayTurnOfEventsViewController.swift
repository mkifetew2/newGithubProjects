//
//  ThreePlayTurnOfEventsViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-05-12.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit

class ThreePlayTurnOfEventsViewController: UIViewController {

    @IBOutlet weak var dice: UIImageView!
    
    @IBOutlet weak var player1Roll: UIButton!
    @IBOutlet weak var player2Roll: UIButton!
    @IBOutlet weak var player3Roll: UIButton!
    
    
    @IBOutlet weak var player1score: UILabel!
    @IBOutlet weak var player2score: UILabel!
    @IBOutlet weak var player3score: UILabel!
    
    
    var diceNameArr = ["DICE1B", "DICE2B", "DICE3B", "DICE4B", "DICE5B", "DICE6B"]
    var numArr = ["0", "1", "2", "3", "4", "5"]
    
    var randomIndexVar1 : Int?
    
    var player1tempScore : Int = 0
    var player2tempScore : Int = 0
    var player3tempScore : Int = 0
    
    var amtOfRollsLeft : Int = 3
    
    var player1active : Bool = true
    var player2active : Bool = true
    var player3active : Bool = true

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player2Roll.isEnabled = false
        player2Roll.isHidden = true
        player3Roll.isEnabled = false
        player3Roll.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testForTieFunctionality()
    {
        randomIndexVar1 = 2
    }
    
    
    func diceRoll()
    {
        let randomNum = numArr[Int(arc4random_uniform(UInt32(diceNameArr.count)))]
        
        let startIndex = randomNum[randomNum.startIndex]
        
        if let number1 = Int(String(startIndex))
        {
            randomIndexVar1 = number1
        }
        UIUpdates()
    }
    
    func UIUpdates()
    {
      dice.image = UIImage(named: diceNameArr[randomIndexVar1!])
    }
    
    @IBAction func p1rollPressed(_ sender: UIButton)
    {
        if player1active == true
        {
            diceRoll()
            //testForTieFunctionality()
            player1score.text = String(randomIndexVar1! + 1)
            player1tempScore = Int(player1score.text!)!
            player1Roll.isEnabled = false
            player1Roll.isHidden = true
    
        if player2active == true
        {
            player2Roll.isEnabled = true
            player2Roll.isHidden = false
        }
        
        if player2active == false && player3active == true
        {
            player3Roll.isEnabled = true
            player3Roll.isHidden = false
        }
            
            
        player1active = true
        amtOfRollsLeft = amtOfRollsLeft - 1
        }
    }
    
    @IBAction func p2rollPressed(_ sender: UIButton)
    {
        if player2active == true
        {
        diceRoll()
        //testForTieFunctionality()
        player2score.text = String(randomIndexVar1! + 1)
        player2tempScore = Int(player2score.text!)!
        player2Roll.isEnabled = false
        player2Roll.isHidden = true
            
        if player3active == true
        {
            player3Roll.isEnabled = true
            player3Roll.isHidden = false
        }
        
        player2active = false
        amtOfRollsLeft = amtOfRollsLeft - 1
        checkForPlayOrder()
        }
    }
    
    @IBAction func p3rollPressed(_ sender: UIButton)
    {
        if player3active == true
        {
            diceRoll()
            player3score.text = String(randomIndexVar1! + 1)
            player3tempScore = Int(player3score.text!)!
            player3Roll.isEnabled = false
            player3Roll.isHidden = true 
            amtOfRollsLeft = amtOfRollsLeft - 1
            checkForPlayOrder()
        }
        player3active = false
    }
    
    
    func resetEverythingP1nP2()
    {
        player1tempScore = 0
        player2tempScore = 0
        player3tempScore = 0
        player1active = true
        player2active = true
        player1score.text = "0"
        player2score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
    }
    
    func resetEverythingP1nP3()
    {
        player1tempScore = 0
        player2tempScore = 0
        player3tempScore = 0
        player1active = true
        player3active = true
        player1score.text = "0"
        player3score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
    }
    
    func resetEverythingP2nP3()
    {
        player1tempScore = 0
        player2tempScore = 0
        player3tempScore = 0
        player2active = true
        player3active = true
        player2score.text = "0"
        player3score.text = "0"
        randomIndexVar1 = 0
        player2Roll.isEnabled = true
        player2Roll.isHidden = false
    }
    
    func resetEverything()
    {
        player1tempScore = 0
        player2tempScore = 0
        player3tempScore = 0
        player1active = true
        player2active = true
        player3active = true
        player1score.text = "0"
        player2score.text = "0"
        player3score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false

    }
    
    
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
                self.resetEverything()
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
                self.resetEverythingP1nP2()
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
                self.resetEverythingP1nP3()
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
                self.resetEverythingP2nP3()
            }
            
            amtOfRollsLeft = 2
            
            alertController2.addAction(action2)
            self.present(alertController2, animated: true, completion: nil)
        }
        
      
        
        
        }
    }
    

   

}