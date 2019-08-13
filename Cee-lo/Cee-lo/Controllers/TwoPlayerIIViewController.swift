//
//  TwoPlayerIIViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-04-28.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit

class TwoPlayerIIViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var dice1Image: UIImageView!
    @IBOutlet weak var dice2Image: UIImageView!
    @IBOutlet weak var dice3Image: UIImageView!
   
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    var player1Turns : Int = 0
    var player2Turns : Int = 0
    
    
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var betTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var player1diceResult: UILabel!
    @IBOutlet weak var player2diceResult: UILabel!
    
    
    var threeNumArr : [Int] = [0,0,0]
    var diceNameArr = ["DICE1B", "DICE2B", "DICE3B", "DICE4B", "DICE5B", "DICE6B"]
    
    var player1fourFiveSix = false
    var player2fourFiveSix = false
    
    var player1Triple = false
    var player2Triple = false
    
    var player1oneTwoThree = false
    var player2oneTwoThree = false
    
    var player1score : Int = 0
    var player2score : Int = 0
    
    var player1hasGone : Bool = false
    var player2hasGone : Bool = false
    
    var gameDecided : Bool = false
    
    var randomIndexVar1 : Int?
    var randomIndexVar2 : Int?
    var randomIndexVar3 : Int?
    
    var minTurns = 0
    
    @IBOutlet weak var player1rollButton: UIButton!
    @IBOutlet weak var player2rollButton: UIButton!
    
    let numArray = [1, 2, 3, 4, 5, 6]
    var message = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dice1Image.image = UIImage(named: "DICE2B")
        dice2Image.image = UIImage(named: "DICE3B")
        dice3Image.image = UIImage(named: "DICE4B")
        betTextField.delegate = self
        player2rollButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //After view is loaded an alert comes to the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let alertController = UIAlertController(title: "Wager entry", message: "Place a bet entry if playing to gamble next to bet label before rolling", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed okay");
        }
        
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //This should be limiting the textfield to no more than 8 characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 8
    }
    
    //Functions to test the functionality of hiearchy of winning
    func testPlayer1Roll()
    {
        randomIndexVar1 = 3
        randomIndexVar2 = 5
        randomIndexVar3 = 4
        threeNumArr[0] = randomIndexVar1!
        threeNumArr[1] = randomIndexVar2!
        threeNumArr[2] = randomIndexVar3!
        UIUpdates(listofNums: threeNumArr)
    }
    
    func testPlayer2Roll()
    {
        randomIndexVar1 = 4
        randomIndexVar2 = 3
        randomIndexVar3 = 5
        threeNumArr[0] = randomIndexVar1!
        threeNumArr[1] = randomIndexVar2!
        threeNumArr[2] = randomIndexVar3!
        UIUpdates(listofNums: threeNumArr)
    }
    
    func diceRoll()
    {
            //[0,1,2,3,4,5]
            //[1,2,3,4,5,6]
            var listOfNonWinningScores = ["013", "014", "015", "023", "024", "025", "031", "032", "034", "035", "041", "042", "043", "045", "051", "052", "053","054","103", "104", "105", "123", "124", "125", "130", "132", "134", "135", "140", "142", "143", "145", "150", "152", "153", "154","203", "204", "205", "213", "214", "215", "230", "231", "234", "235", "240", "241", "243", "245", "250", "251", "253", "254", "301", "302", "304", "305", "310", "312", "314", "315", "320", "321", "324", "325", "340", "341", "342", "350", "351", "352", "401", "402", "403", "405", "410", "412", "413", "415", "420", "421", "423", "425", "430", "431", "432", "450", "451", "452", "501", "502", "503", "504", "510", "512", "513", "514", "520", "521", "523", "524", "530", "531", "532", "540", "541", "542"]
        
            var listofPossibleScores = ["000", "001", "002", "003", "004", "005", "010", "011", "012", "020", "021", "022", "030", "033", "040", "044", "050", "055",
                                        "100", "101", "102", "110", "111", "112", "113", "114,", "115", "120", "121", "122", "131", "133", "141", "144", "151", "155",
                                        "200", "201", "202", "210", "211", "212", "220", "221", "222", "223", "224", "225", "232", "233", "242", "244", "252", "255",
                                        "300", "303", "311", "313", "322", "323", "330", "331", "332", "333", "334", "335", "343", "344", "353", "355",
                                        "400", "404", "411", "414", "422", "424", "433", "434", "440", "441", "442", "443", "444" , "445", "454", "455",
                                        "500", "505", "511", "515", "522", "535", "533", "535", "544", "545", "550", "551", "552", "553", "554", "555"]
        
        
            
            
            if(minTurns < 2)
            {
                let randomNum = listOfNonWinningScores[Int(arc4random_uniform(UInt32(listOfNonWinningScores.count)))]
                print(randomNum)
                
                let startIndex = randomNum[randomNum.startIndex]
                print(startIndex)
                
                let inBetween = randomNum.index(after: randomNum.startIndex)
                print(randomNum[inBetween])
                
                let lastNum = randomNum.index(before: randomNum.endIndex)
                print(randomNum[lastNum])
                
                if let number1 = Int(String(startIndex))
                {
                    randomIndexVar1 = number1
                }
                
                if let number2 = Int(String(randomNum[inBetween]))
                {
                    randomIndexVar2 = number2
                }
                
                if let number3 = Int(String(randomNum[lastNum]))
                {
                    randomIndexVar3 = number3
                }
                //play 5-7 sec video here
                
                threeNumArr[0] = randomIndexVar1!
                threeNumArr[1] = randomIndexVar2!
                threeNumArr[2] = randomIndexVar3!
                UIUpdates(listofNums: threeNumArr)
                minTurns = minTurns + 1
                
            }
                
            else
            {
                listofPossibleScores.append(contentsOf: listOfNonWinningScores)
                let randomNum2 = listofPossibleScores[Int(arc4random_uniform((UInt32(listofPossibleScores.count))))]
                let startIndex2 = randomNum2[randomNum2.startIndex]
                print(startIndex2)
                
                let inBetween2 = randomNum2.index(after: randomNum2.startIndex)
                print(randomNum2[inBetween2])
                
                let lastNum2 = randomNum2.index(before: randomNum2.endIndex)
                print(randomNum2[lastNum2])
                
                if let number1 = Int(String(startIndex2))
                {
                    randomIndexVar1 = number1
                }
                
                if let number2 = Int(String(randomNum2[inBetween2]))
                {
                    randomIndexVar2 = number2
                }
                
                if let number3 = Int(String(randomNum2[lastNum2]))
                {
                    randomIndexVar3 = number3
                }
                //play 5-7 sec video here
                threeNumArr[0] = randomIndexVar1!
                threeNumArr[1] = randomIndexVar2!
                threeNumArr[2] = randomIndexVar3!
                UIUpdates(listofNums: threeNumArr)
            }
        
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
    
    @IBAction func player1roll(_ sender: UIButton)
    {
        //whether or not the person uses the submit button to enter bet if there is anything inside the textfield it will become the bet
        betLabel.text! = betTextField.text!
        betTextField.isHidden = true
        betTextField.isEnabled = false
        betLabel.isEnabled = true
        betLabel.isHidden = false
        
        
        
        player1score = 0
        player2score = 0
        gameDecided = false
        player1Turns = player1Turns + 1
        submitButton.isEnabled = false
        resetButton.isEnabled = false
        diceRoll()
        //testPlayer1Roll()
        print("player 1 has gone \(player1Turns) times")
        while (player1hasGone == false)
        {
            if (dice2Image.image! != dice3Image.image! && dice1Image.image! != dice3Image.image! &&  dice1Image.image! != dice2Image.image!)
            {
                if (diceNameArr[threeNumArr[0]] == "DICE4B" && diceNameArr[threeNumArr[1]] == "DICE5B" && diceNameArr[threeNumArr[2]] == "DICE6B" ||
                    diceNameArr[threeNumArr[0]] == "DICE4B" && diceNameArr[threeNumArr[1]] == "DICE6B" && diceNameArr[threeNumArr[2]] == "DICE5B" ||
                    diceNameArr[threeNumArr[0]] == "DICE5B" && diceNameArr[threeNumArr[1]] == "DICE4B" && diceNameArr[threeNumArr[2]] == "DICE6B" ||
                    diceNameArr[threeNumArr[0]] == "DICE5B" && diceNameArr[threeNumArr[1]] == "DICE6B" && diceNameArr[threeNumArr[2]] == "DICE4B" ||
                    diceNameArr[threeNumArr[0]] == "DICE6B" && diceNameArr[threeNumArr[1]] == "DICE4B" && diceNameArr[threeNumArr[2]] == "DICE5B" ||
                    diceNameArr[threeNumArr[0]] == "DICE6B" && diceNameArr[threeNumArr[1]] == "DICE5B" && diceNameArr[threeNumArr[2]] == "DICE4B")
                    {
                        minTurns = 0
                        player1fourFiveSix = true
                        player1score = 6
                        player1Score.text = String(player1score)
                        player2Score.text = "0"
                        player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                        player1rollButton.isEnabled = false
                        player1rollButton.isHidden = true
                        player2rollButton.isEnabled = true
                        player2rollButton.isHidden = false
                        player2hasGone = false
                        player1hasGone = true
                        //reloadInputViews()
                        print("here456")
                        break
                    
                    }
                
                if (diceNameArr[threeNumArr[0]] == "DICE1B" && diceNameArr[threeNumArr[1]] == "DICE2B" && diceNameArr[threeNumArr[2]] == "DICE3B" ||
                    diceNameArr[threeNumArr[0]] == "DICE1B" && diceNameArr[threeNumArr[1]] == "DICE3B" && diceNameArr[threeNumArr[2]] == "DICE2B" ||
                    diceNameArr[threeNumArr[0]] == "DICE2B" && diceNameArr[threeNumArr[1]] == "DICE1B" && diceNameArr[threeNumArr[2]] == "DICE3B" ||
                    diceNameArr[threeNumArr[0]] == "DICE2B" && diceNameArr[threeNumArr[1]] == "DICE3B" && diceNameArr[threeNumArr[2]] == "DICE1B" ||
                    diceNameArr[threeNumArr[0]] == "DICE3B" && diceNameArr[threeNumArr[1]] == "DICE1B" && diceNameArr[threeNumArr[2]] == "DICE2B" ||
                    diceNameArr[threeNumArr[0]] == "DICE3B" && diceNameArr[threeNumArr[1]] == "DICE2B" && diceNameArr[threeNumArr[2]] == "DICE1B")
                    {
                        minTurns = 0
                        player1oneTwoThree = true
                        player1score = 0
                        player1Score.text = String(player1score)
                        player2Score.text = "0"
                        player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                        player1rollButton.isEnabled = false
                        player1rollButton.isHidden = true
                        player2rollButton.isEnabled = true
                        player2rollButton.isHidden = false
                        player2hasGone = false
                        player1hasGone = true
                        //reloadInputViews()
                        print("here123")
                        break
                    }

                player1rollButton.isEnabled = true
                player1score = 0
                player1Score.text = String(player1score)
                player2Score.text = "0"
                player2rollButton.isEnabled = false
                player1hasGone = false
                print("roll again")
                break
            }
            
            else if (dice1Image.image! == dice2Image.image! && dice2Image.image! == dice3Image.image!)
            {
                minTurns = 0
                player1Triple = true
                player1score = Int(threeNumArr[0] + 1)
                player1Score.text = String(player1score)
                player2Score.text = "0"
                player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player1rollButton.isEnabled = false
                player1rollButton.isHidden = true
                player2rollButton.isEnabled = true
                player2rollButton.isHidden = false
                player2hasGone = false
                player1hasGone = true
                //reloadInputViews()
                print("hereTriple1")
                break
                
            }
            
            else if (dice1Image.image! == dice2Image.image!)
            {
                minTurns = 0
                player1score = Int(threeNumArr[2] + 1)
                player1Score.text = String(player1score)
                player2Score.text = "0"
                player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player1rollButton.isEnabled = false
                player1rollButton.isHidden = true
                player2rollButton.isEnabled = true
                player2rollButton.isHidden = false
                player2hasGone = false
                player1hasGone = true
                //reloadInputViews()
                print("here1")
                break
                
            }
            
            else if (dice1Image.image! == dice3Image.image!)
            {
                minTurns = 0
                player1score = Int(threeNumArr[1] + 1)
                player1Score.text = String(player1score)
                player2Score.text = "0"
                player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player1rollButton.isEnabled = false
                player1rollButton.isHidden = true
                player2rollButton.isEnabled = true
                player2rollButton.isHidden = false
                player2hasGone = false
                player1hasGone = true
                //reloadInputViews()
                print("here2")
                break
                
            }
            
            else if (dice2Image.image! == dice3Image.image!)
            {
                minTurns = 0
                player1score = Int(threeNumArr[0] + 1)
                player1Score.text = String(player1score)
                player2Score.text = "0"
                player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player1rollButton.isEnabled = false
                player1rollButton.isHidden = true
                player2rollButton.isEnabled = true
                player2rollButton.isHidden = false
                player2hasGone = false
                player1hasGone = true
                //reloadInputViews()
                print("here3")
                break
            }
            
            
            
        }
        print("Player 1 has went")
    }
    
    
    @IBAction func player2roll(_ sender: UIButton)
    {
        diceRoll()
        //testPlayer2Roll()
        player2Turns = player2Turns + 1
        print("player 2 has gone \(player2Turns) times")
        while(player2hasGone == false)
        {
            
            //Player 2 dice details
            
            if (dice2Image.image! != dice3Image.image! && dice1Image.image! != dice3Image.image! &&  dice1Image.image! != dice2Image.image!)
            {
                if (diceNameArr[threeNumArr[0]] == "DICE4B" && diceNameArr[threeNumArr[1]] == "DICE5B" && diceNameArr[threeNumArr[2]] == "DICE6B" ||
                    diceNameArr[threeNumArr[0]] == "DICE4B" && diceNameArr[threeNumArr[1]] == "DICE6B" && diceNameArr[threeNumArr[2]] == "DICE5B" ||
                    diceNameArr[threeNumArr[0]] == "DICE5B" && diceNameArr[threeNumArr[1]] == "DICE4B" && diceNameArr[threeNumArr[2]] == "DICE6B" ||
                    diceNameArr[threeNumArr[0]] == "DICE5B" && diceNameArr[threeNumArr[1]] == "DICE6B" && diceNameArr[threeNumArr[2]] == "DICE4B" ||
                    diceNameArr[threeNumArr[0]] == "DICE6B" && diceNameArr[threeNumArr[1]] == "DICE4B" && diceNameArr[threeNumArr[2]] == "DICE5B" ||
                    diceNameArr[threeNumArr[0]] == "DICE6B" && diceNameArr[threeNumArr[1]] == "DICE5B" && diceNameArr[threeNumArr[2]] == "DICE4B")
                    {
                        minTurns = 0
                        player2fourFiveSix = true
                        player2score = 6
                        player2Score.text = String(player2score)
                        player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                        player2rollButton.isEnabled = false
                        player2rollButton.isHidden = true
                        player1hasGone = false
                        player2hasGone = true
                        //reloadInputViews()
                        print("here456")
                        checkWhoWon()
                        break
                    }
                
                if (diceNameArr[threeNumArr[0]] == "DICE1B" && diceNameArr[threeNumArr[1]] == "DICE2B" && diceNameArr[threeNumArr[2]] == "DICE3B" ||
                    diceNameArr[threeNumArr[0]] == "DICE1B" && diceNameArr[threeNumArr[1]] == "DICE3B" && diceNameArr[threeNumArr[2]] == "DICE2B" ||
                    diceNameArr[threeNumArr[0]] == "DICE2B" && diceNameArr[threeNumArr[1]] == "DICE1B" && diceNameArr[threeNumArr[2]] == "DICE3B" ||
                    diceNameArr[threeNumArr[0]] == "DICE2B" && diceNameArr[threeNumArr[1]] == "DICE3B" && diceNameArr[threeNumArr[2]] == "DICE1B" ||
                    diceNameArr[threeNumArr[0]] == "DICE3B" && diceNameArr[threeNumArr[1]] == "DICE1B" && diceNameArr[threeNumArr[2]] == "DICE2B" ||
                    diceNameArr[threeNumArr[0]] == "DICE3B" && diceNameArr[threeNumArr[1]] == "DICE2B" && diceNameArr[threeNumArr[2]] == "DICE1B")
                    {
                        minTurns = 0
                        player2oneTwoThree = true
                        player2score = 0
                        player2Score.text = String(player2score)
                        player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                        player2rollButton.isEnabled = false
                        player2rollButton.isHidden = true
                        player1hasGone = false
                        player2hasGone = true
                        //reloadInputViews()
                        print("here123")
                        checkWhoWon()
                        break
                    }
                player2rollButton.isEnabled = true
                player2score = 0
                player2Score.text = String(player2score)
                player1rollButton.isEnabled = false
                player2hasGone = false
                print("roll again")
                break
            }
                
            else if (dice1Image.image! == dice2Image.image! && dice2Image.image! == dice3Image.image!)
            {
                minTurns = 0
                player2Triple = true
                player2score = Int(threeNumArr[0] + 1)
                player2Score.text = String(player2score)
                player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player2rollButton.isEnabled = false
                player2rollButton.isHidden = true
                player1hasGone = false
                player2hasGone = true
                //reloadInputViews()
                print("hereTriple2")
                checkWhoWon()
                break
                
            }
            
            else if (dice1Image.image! == dice2Image.image!)
            {
                minTurns = 0
                player2score = Int(threeNumArr[2] + 1)
                player2Score.text = String(player2score)
                player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player2rollButton.isEnabled = false
                player2rollButton.isHidden = true
                player1hasGone = false
                player2hasGone = true
                //reloadInputViews()
                print("here 4")
                checkWhoWon()
                break
            }
            
            else if (dice1Image.image! == dice3Image.image!)
            {
                minTurns = 0
                player2score = Int(threeNumArr[1] + 1)
                player2Score.text = String(player2score)
                player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player2rollButton.isEnabled = false
                player2rollButton.isHidden = true
                player1hasGone = false
                player2hasGone = true
                //reloadInputViews()
                print("here5")
                checkWhoWon()
                break
            }
            
            else if (dice2Image.image! == dice3Image.image!)
            {
                minTurns = 0
                player2score = Int(threeNumArr[0] + 1)
                player2Score.text = String(player2score)
                 player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player2rollButton.isEnabled = false
                player2rollButton.isHidden = true
                player1hasGone = false
                player2hasGone = true
                //reloadInputViews()
                print("here6")
                checkWhoWon()
                break
            }
           
            
        }
            print("Player 2 has went")
            
            
    }
    
    public func resetEverythingButBetAmt()
    {
        player1diceResult.text = "0-0-0"
        player2diceResult.text = "0-0-0"
        player1score = 0
        player2score = 0
        player1Score.text = "0"
        player2Score.text = "0"
        player2oneTwoThree = false
        player1oneTwoThree = false
        player2fourFiveSix = false
        player1fourFiveSix = false
        player1Triple = false
        player2Triple = false
        randomIndexVar1 = 0
        randomIndexVar2 = 0
        randomIndexVar3 = 0
        gameDecided = false
        minTurns = 0
        threeNumArr = [0,0,0]
        player1hasGone = false
        player2hasGone = false
        player1rollButton.isHidden = false
        player1rollButton.isEnabled = true
    
    }
    
    public func resetEverything()
    {
        player1diceResult.text = "0-0-0"
        player2diceResult.text = "0-0-0"
        player1score = 0
        player2score = 0
        player1Score.text = "0"
        player2Score.text = "0"
        player2oneTwoThree = false
        player1oneTwoThree = false
        player2fourFiveSix = false
        player1fourFiveSix = false
        player1Triple = false
        player2Triple = false
        randomIndexVar1 = 0
        randomIndexVar2 = 0
        randomIndexVar3 = 0
        gameDecided = false
        minTurns = 0
        threeNumArr = [0,0,0]
        player1hasGone = false
        player2hasGone = false
        submitButton.isEnabled = true
        resetButton.isEnabled = true
        betLabel.text = ""
        betTextField.text = ""
        betTextField.isHidden = false
        betTextField.isEnabled = true
        player1rollButton.isHidden = false
        player1rollButton.isEnabled = true 
    }
    
    func checkWhoWon()
    {
        
        while(gameDecided == false)
        {
            if (player1fourFiveSix == true && player2fourFiveSix == false)
            {
                message = "Player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                print("player 1 has won")
                gameDecided = true
                gameOver()
                break
            }
            
            else if (player1fourFiveSix == false && player2fourFiveSix == true)
            {
                message = "Player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                print("player 2 has won")
                gameDecided = true
                gameOver()
                break
            }
           
            else if (player1fourFiveSix == true && player2fourFiveSix == true)
            {
                message = "It's a tie"
                print("It's a tie")
                gameDecided = true
                gameTied()
                break
            }
            
            else if (player1Triple == true && player2Triple == false)
            {
                
                message = "Player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                print("player 1 has won")
                gameDecided = true
                gameOver()
                break
            }
            
            else if (player1Triple == false && player2Triple == true)
            {
                message = "Player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                print("player 2 has won")
                gameDecided = true
                gameOver()
                break
            }
            
            else if(player1Triple == true && player2Triple == true)
            {
                if(player1score > player2score)
                {
                    message = "Player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                    print("player 1 has won")
                    gameDecided = true
                    gameOver()
                    break
                }
                else if (player1score < player2score)
                {
                    message = "Player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                    print("player 2 has won")
                    gameDecided = true
                    gameOver()
                    break
                }
                else if (player1score == player2score)
                {
                    message = "Tie "
                    print("tie")
                    gameDecided = true
                    gameTied()
                    break
                }
            }
            
            else if(player1oneTwoThree == true && player2oneTwoThree == false)
            {
                message = "Player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                print("player 2 has won")
                gameDecided = true
                gameOver()
                break
            }
            else if(player1oneTwoThree == false && player2oneTwoThree == true)
            {
                message = "Player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                print("player 1 has won")
                gameDecided = true
                gameOver()
                break
            }
            
            else if(player1oneTwoThree == true && player2oneTwoThree == true)
            {
                message = "Both players got 1-2-3, you can play again by running it back or take your original bet back and quit game"
                print("both lost")
                gameDecided = true
                gameTied()
                break
            }
            
            else if(player1score > player2score)
            {
                message = "Player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                print("player 1 has won")
                gameDecided = true
                gameOver()
                break
            }
            
            else if(player1score < player2score)
            {
                message = "Player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                print("player 2 has won")
                gameDecided = true
                gameOver()
                break
            }
            
            else if(player1score == player2score)
            {
                message = "Tie game, you can play again by running it back or take your original bet back and quit game"
                print("tie game")
                gameDecided = true
                gameTied()
                break
            }
            
            
        }
       
    }
    
    
    //Winner has been decided
    func gameOver()
    {
        print("Game is over")
        let alertController = UIAlertController(title: "Game complete", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Run it back?", style: .default) { (action:UIAlertAction) in
            self.resetEverything()
            self.performSegue(withIdentifier: "runItBack", sender: self)
            print("You've run it back");
        }
        let action2 = UIAlertAction(title: "Quit game", style: .default)
        { (action: UIAlertAction) in
            self.resetEverything()
            self.performSegue(withIdentifier: "backToLaunch", sender: self)
            print("quit game")
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Winner is still being decided
    func gameTied()
    {
        print("Game is tied")
        let alertController = UIAlertController(title: "Game complete", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Run it back?", style: .default) { (action:UIAlertAction) in
            self.resetEverythingButBetAmt()
            print("You've run it back");
        }
        let action2 = UIAlertAction(title: "Quit game", style: .default)
        { (action: UIAlertAction) in
            self.resetEverything()
            self.performSegue(withIdentifier: "backToLaunch", sender: self)
            print("quit game")
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func betSubmitted(_ sender: UIButton) {
        betLabel.text! = betTextField.text!
        betTextField.isHidden = true
        betTextField.isEnabled = false
        betLabel.isEnabled = true 
        betLabel.isHidden = false 
    }
    
    @IBAction func resetBet(_ sender: UIButton) {
        betTextField.isHidden = false
        betLabel.isHidden = true
        betTextField.isEnabled = true
        betTextField.text = ""
        betLabel.text = ""
    }
    

    
    
            
}


    
    

