//
//  ViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-04-22.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit

class TwoPlayerController: UIViewController {

   
    @IBOutlet weak var dice1Image: UIImageView!
    @IBOutlet weak var dice2Image: UIImageView!
    @IBOutlet weak var dice3Image: UIImageView!
    
    @IBOutlet weak var player2scoreLabel: UILabel!
    @IBOutlet weak var player1scoreLabel: UILabel!
    
    @IBOutlet weak var player1rollButton: UIButton!
    @IBOutlet weak var player2rollButton: UIButton!
    var threeNumArr : [Int] = [0,0,0]
    var diceNameArr = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    
    var player1score : Int = 0
    var player2score : Int = 0
    
    var player1hasGone : Bool = false
    var player2hasGone : Bool = false
    
    var randomIndexVar1 : Int?
    var randomIndexVar2 : Int?
    var randomIndexVar3 : Int?
    
    var minTurns = 0
    
    
    let numArray = [1, 2, 3, 4, 5, 6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       dice1Image.image = UIImage(named: "dice2")
       dice2Image.image = UIImage(named: "dice3")
       dice3Image.image = UIImage(named: "dice4")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var textfield = UITextField()
        let alertController = UIAlertController(title: "Alert", message: "This is an alert.", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Default", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        
        alertController.addAction(action1)
        
        alertController.addTextField { (alertTextField) in
            textfield = alertTextField
            alertTextField.placeholder = "Category Name"
            
        }
        
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func diceRoll()
    {
        randomIndexVar1 = Int(arc4random_uniform(6))
        randomIndexVar2 = Int(arc4random_uniform(6))
        randomIndexVar3 = Int(arc4random_uniform(6))
        
       if (randomIndexVar1 == randomIndexVar2 && minTurns < 2 || randomIndexVar1 == randomIndexVar3 && minTurns < 2 || randomIndexVar2 == randomIndexVar3 && minTurns < 2)
       {
            randomIndexVar1 = Int(arc4random_uniform(6))
            randomIndexVar2 = Int(arc4random_uniform(6))
            randomIndexVar3 = Int(arc4random_uniform(6))
            minTurns = minTurns + 1
        }
    

        threeNumArr[0] = randomIndexVar1!
        threeNumArr[1] = randomIndexVar2!
        threeNumArr[2] = randomIndexVar3!
        
        UIUpdates(listofNums: threeNumArr)
        
    }
    
    func UIUpdates(listofNums : [Int])
    {
        dice1Image.image = UIImage(named: diceNameArr[threeNumArr[0]])
        dice2Image.image = UIImage(named: diceNameArr[threeNumArr[1]])
        dice3Image.image = UIImage(named: diceNameArr[threeNumArr[2]])
        print(diceNameArr[threeNumArr[0]])
        print(diceNameArr[threeNumArr[1]])
        print(diceNameArr[threeNumArr[2]])
    }
    
    

    @IBAction func player1roll(_ sender: UIButton) {
       
        diceRoll()
        
        while(player1hasGone == false)
        {
            
            //Player 1 dice details
            
            if (dice2Image.image! != dice3Image.image! && dice1Image.image! != dice3Image.image! &&  dice1Image.image! != dice2Image.image!)
            {
                player1rollButton.isEnabled = true
                player1score = 0
                player1scoreLabel.text = String(player1score)
                player2scoreLabel.text = "0"
                player2rollButton.isEnabled = false
                player1hasGone = false
                print("roll again")
                break
            }
                
            else if (dice1Image.image! == dice2Image.image!)
            {
                player1score = Int(threeNumArr[2] + 1)
                player1scoreLabel.text = String(player1score)
                player2scoreLabel.text = "0"
                player1rollButton.isEnabled = false
                player2rollButton.isEnabled = true
                player2hasGone = false
                player1hasGone = true
                //reloadInputViews()
                print("here1")
                minTurns = 0
                break
                
            }
            
           else if (dice1Image.image! == dice3Image.image!)
            {
                player1score = Int(threeNumArr[1] + 1)
                player1scoreLabel.text = String(player1score)
                player2scoreLabel.text = "0"
                player1rollButton.isEnabled = false
                player2rollButton.isEnabled = true
                player2hasGone = false
                player1hasGone = true
                //reloadInputViews()
                print("here2")
                minTurns = 0
                break
                
            }
            
           else if (dice2Image.image! == dice3Image.image!)
            {
                player1score = Int(threeNumArr[0] + 1)
                player1scoreLabel.text = String(player1score)
                player2scoreLabel.text = "0"
                player1hasGone = true
                player1rollButton.isEnabled = false
                player2rollButton.isEnabled = true
                player2hasGone = false
                player1hasGone = true
                //reloadInputViews()
                print("here3")
                minTurns = 0
                break
            }
            
        }
        
        print("Player 1 has went")

    }
    
    @IBAction func player2rollPressed(_ sender: UIButton) {
  
        diceRoll()
        while(player2hasGone == false)
        {
            
            //Player 2 dice details
            
            if (dice2Image.image! != dice3Image.image! && dice1Image.image! != dice3Image.image! &&  dice1Image.image! != dice2Image.image!)
            {
                player2rollButton.isEnabled = true
                player2score = 0
                player2scoreLabel.text = String(player2score)
                player1rollButton.isEnabled = false
                player2hasGone = false
                print("roll again")
                minTurns = 0
                break
            }
            else if (dice1Image.image! == dice2Image.image!)
            {
                player2score = Int(threeNumArr[2] + 1)
                player2scoreLabel.text = String(player2score)
                player2rollButton.isEnabled = false
                player1rollButton.isEnabled = true
                player1hasGone = false
                player2hasGone = true
                //reloadInputViews()
                print("here 4")
                minTurns = 0
                break
            }
            
           else if (dice1Image.image! == dice3Image.image!)
            {
                player2score = Int(threeNumArr[1] + 1)
                player2scoreLabel.text = String(player2score)
                player2rollButton.isEnabled = false
                player1rollButton.isEnabled = true
                player1hasGone = false
                player2hasGone = true
                //reloadInputViews()
                print("here5")
                minTurns = 0
                break
            }
            
           else if (dice2Image.image! == dice3Image.image!)
            {
                player2score = Int(threeNumArr[0] + 1)
                player2scoreLabel.text = String(player2score)
                player2rollButton.isEnabled = false
                player1rollButton.isEnabled = true
                player1hasGone = false
                player2hasGone = true
                //reloadInputViews()
                print("here6")
                minTurns = 0
                break
            }
        }
        print("Player 2 has went")
    }
    


        
    }
    

   
    
    
    



