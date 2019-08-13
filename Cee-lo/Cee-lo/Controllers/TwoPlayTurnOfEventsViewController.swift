//
//  TwoPlayTurnOfEventsViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-05-12.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit


class TwoPlayTurnOfEventsViewController: UIViewController {

    
//    var playerArr = [Temp2PlayerGame]()
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var dice: UIImageView!
    @IBOutlet weak var player1Roll: UIButton!
    @IBOutlet weak var player2Roll: UIButton!
    
    @IBOutlet weak var player1score: UILabel!
    @IBOutlet weak var player2score: UILabel!
    
    var diceNameArr = ["DICE1B", "DICE2B", "DICE3B", "DICE4B", "DICE5B", "DICE6B"]
    var numArr = ["0", "1", "2", "3", "4", "5"]
    
    var randomIndexVar1 : Int?
    
    var player1tempScore : Int = 0
    var player2tempScore : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player2Roll.isEnabled = false
        player2Roll.isHidden = true 
    }

 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
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
    

    @IBAction func p1rollPressed(_ sender: UIButton)
    {
        diceRoll()
        //testForTieFunctionality()
        print("got here")
        player1score.text = String(randomIndexVar1! + 1)
        player1tempScore = Int(player1score.text!)!
        player1Roll.isEnabled = false
        player2Roll.isEnabled = true
        player1Roll.isHidden = true 
        player2Roll.isHidden = false
        
        
    }
    
    @IBAction func p2rollPressed(_ sender: UIButton)
    {
        diceRoll()
        //testForTieFunctionality()
        player2score.text = String(randomIndexVar1! + 1)
        player2tempScore = Int(player2score.text!)!
        player2Roll.isEnabled = false
        player2Roll.isHidden = true
        checkForPlayOrder()
    }
    
    
    
//    func saveScores()
//    {
//        do{
//            try context.save()
//        }
//        catch{
//            print("Error saving scores\(error)")
//        }
//    }
//    
 
    
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
