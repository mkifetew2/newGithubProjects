//
//  FourPlayTurnOfEventsViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-05-12.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit

class FourPlayTurnOfEventsViewController: UIViewController {

    @IBOutlet weak var dice: UIImageView!
    
    @IBOutlet weak var player1Roll: UIButton!
    @IBOutlet weak var player2Roll: UIButton!
    @IBOutlet weak var player3Roll: UIButton!
    @IBOutlet weak var player4Roll: UIButton!
    
    @IBOutlet weak var player1score: UILabel!
    @IBOutlet weak var player2score: UILabel!
    @IBOutlet weak var player3score: UILabel!
    @IBOutlet weak var player4score: UILabel!
    
    var diceNameArr = ["DICE1B", "DICE2B", "DICE3B", "DICE4B", "DICE5B", "DICE6B"]
    var numArr = ["0", "1", "2", "3", "4", "5"]
    
    var randomIndexVar1 : Int?
    
    var player1tempScore : Float = 0
    var player2tempScore : Float = 0
    var player3tempScore : Float = 0
    var player4tempScore : Float = 0
    
    var amtOfRollsLeft : Int = 4
    
    var player1active : Bool = true
    var player2active : Bool = true
    var player3active : Bool = true
    var player4active : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        player2Roll.isEnabled = false
        player3Roll.isEnabled = false
        player4Roll.isEnabled = false
        player2Roll.isHidden = true
        player3Roll.isHidden = true
        player4Roll.isHidden = true
    }
    
    func disableRolling()
    {
        player1Roll.isEnabled = false
        player2Roll.isEnabled = false
        player3Roll.isEnabled = false
        player4Roll.isEnabled = false
    }
    
    func randomImageFirst()
    {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2)
        {
            self.dice.image = UIImage(named: self.diceNameArr[Int(arc4random_uniform(UInt32(self.diceNameArr.count)))])
            self.disableRolling()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4)
        {
            self.dice.image = UIImage(named: self.diceNameArr[Int(arc4random_uniform(UInt32(self.diceNameArr.count)))])
            self.disableRolling()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)
        {
            self.dice.image = UIImage(named: self.diceNameArr[Int(arc4random_uniform(UInt32(self.diceNameArr.count)))])
            self.disableRolling()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8)
        {
            self.dice.image = UIImage(named: self.diceNameArr[Int(arc4random_uniform(UInt32(self.diceNameArr.count)))])
            self.disableRolling()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
        {
            self.dice.image = UIImage(named: self.diceNameArr[Int(arc4random_uniform(UInt32(self.diceNameArr.count)))])
            self.disableRolling()
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    func UIUpdates()
    {
        dice.image = UIImage(named: diceNameArr[randomIndexVar1!])
    }
    
    
    
  
    @IBAction func p1rollPressed(_ sender: UIButton)
    {
        randomImageFirst()
        if player1active == true
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.diceRoll()
                self.player1score.text = String(self.randomIndexVar1! + 1)
                self.player1tempScore = Float(self.player1score.text!)!
                self.player1Roll.isEnabled = false
                self.player1Roll.isHidden = true
                
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
                
                self.player1active = false
                self.amtOfRollsLeft = self.amtOfRollsLeft - 1
                self.nextScreen()
        }
        }
        
    }
    
    
    @IBAction func p2rollPressed(_ sender: UIButton)
    {
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.9)
            {
                self.nextScreen()
            }
        }
    }
    
    
    @IBAction func p3rollPressed(_ sender: UIButton)
    {
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
                
                if self.player4active == true
                {
                    self.player4Roll.isEnabled = true
                    self.player4Roll.isHidden = false
                }
            }
            player3active = false
            amtOfRollsLeft = amtOfRollsLeft - 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.9)
            {
                self.nextScreen()
            }
        }
     
    }
    
    
    
    @IBAction func p4rollPressed(_ sender: UIButton)
    {
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
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.9)
            {
                self.nextScreen()
            }
        }
        player4active = false
    }
    
    func resetEverything()
    {
        player1tempScore = 0
        player2tempScore = 0
        player3tempScore = 0
        player4tempScore = 0
        player1score.text = "0"
        player2score.text = "0"
        player3score.text = "0"
        player4score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player2active = true
        player3active = true
        player4active = true
        amtOfRollsLeft = 4
    }
    
    func resetEverythingP1nP2nP3()
    {
        player1tempScore = 0
        player2tempScore = 0
        player3tempScore = 0
        player4tempScore = 0.176
        player1score.text = "0"
        player2score.text = "0"
        player3score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player2active = true
        player3active = true
        amtOfRollsLeft = 3
    }
    
    func resetEverythingP1nP2nP4()
    {
        player1tempScore = 0
        player2tempScore = 0
        player4tempScore = 0
        player3tempScore = 0.134
        player1score.text = "0"
        player2score.text = "0"
        player4score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player2active = true
        player4active = true
        amtOfRollsLeft = 3
    }
    
    func resetEverythingP1nP3nP4()
    {
        player1tempScore = 0
        player2tempScore = 0.168
        player3tempScore = 0
        player4tempScore = 0
        player1score.text = "0"
        player3score.text = "0"
        player4score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player3active = true
        player4active = true
        amtOfRollsLeft = 3
    }
    
    func resetEverythingP2nP3nP4()
    {
        player1tempScore = 0.135
        player2tempScore = 0
        player3tempScore = 0
        player4tempScore = 0
        player2score.text = "0"
        player3score.text = "0"
        player4score.text = "0"
        randomIndexVar1 = 0
        player2Roll.isEnabled = true
        player2Roll.isHidden = false
        player2active = true
        player3active = true
        player4active = true
        amtOfRollsLeft = 3
    }
    
    
    
    
    func resetEverythingP1nP2()
    {
        player1tempScore = 0
        player2tempScore = 0
        player3tempScore = 0.14566
        player4tempScore = 0.27779
        player1score.text = "0"
        player2score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player2active = true
        amtOfRollsLeft = 2
    }
    
    func resetEverythingP1nP3()
    {
        player1tempScore = 0
        player2tempScore = 0.12345
        player3tempScore = 0
        player4tempScore = 0.3664
        player1score.text = "0"
        player3score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player3active = true
        amtOfRollsLeft = 2
    }
    
    func resetEverythingP1nP4()
    {
        player1tempScore = 0
        player2tempScore = 0.132
        player3tempScore = 0.211
        player4tempScore = 0
        player1score.text = "0"
        player4score.text = "0"
        randomIndexVar1 = 0
        player1Roll.isEnabled = true
        player1Roll.isHidden = false
        player1active = true
        player4active = true
        amtOfRollsLeft = 2
    }
    
    
    func resetEverythingP2nP3()
    {
        player1tempScore = 0.14
        player2tempScore = 0
        player3tempScore = 0
        player4tempScore = 0.22
        player2score.text = "0"
        player3score.text = "0"
        randomIndexVar1 = 0
        player2Roll.isEnabled = true
        player2Roll.isHidden = false
        player2active = true
        player3active = true
        amtOfRollsLeft = 2
    }
    
    func resetEverythingP2nP4()
    {
        player1tempScore = 0.11
        player2tempScore = 0
        player3tempScore = 0.21
        player4tempScore = 0
        player2score.text = "0"
        player4score.text = "0"
        randomIndexVar1 = 0
        player2Roll.isEnabled = true
        player2Roll.isHidden = false
        player2active = true
        player4active = true
        amtOfRollsLeft = 2
    }
    
    func resetEverythingP3nP4()
    {
        player1tempScore = 0.1356
        player2tempScore = 0.7553
        player3tempScore = 0
        player4tempScore = 0
        player3score.text = "0"
        player4score.text = "0"
        randomIndexVar1 = 0
        player3Roll.isEnabled = true
        player3Roll.isHidden = false
        player3active = true
        player4active = true
        amtOfRollsLeft = 2
    }
    
    
    
    func nextScreen()
    {
        if(amtOfRollsLeft == 0)
        {
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
                
                amtOfRollsLeft = 4
                
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
            
            amtOfRollsLeft = 4
            
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
        
        amtOfRollsLeft = 3
        
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
        
        amtOfRollsLeft = 3
        
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
        
        amtOfRollsLeft = 3
        
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
        
        amtOfRollsLeft = 3
        
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
        
        amtOfRollsLeft = 2
        
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
        
        amtOfRollsLeft = 2
        
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
        
        amtOfRollsLeft = 2
        
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
        
        amtOfRollsLeft = 2
        
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
        
        amtOfRollsLeft = 2
        
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
        
        amtOfRollsLeft = 2
        
        alertController2.addAction(action2)
        self.present(alertController2, animated: true, completion: nil)
        
        }
        
        
    
    
        }
    
    }
    
 

}
