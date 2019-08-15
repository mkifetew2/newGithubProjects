//
//  ThreePlayerViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-04-23.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit

class ThreePlayerViewController: UIViewController {

   
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    @IBOutlet weak var betTextField: UITextField!
    @IBOutlet weak var betLabel: UILabel!
    
    @IBOutlet weak var dice1: UIImageView!
    @IBOutlet weak var dice2: UIImageView!
    @IBOutlet weak var dice3: UIImageView!
    
    
    @IBOutlet weak var player1rollButton: UIButton!
    @IBOutlet weak var player2rollButton: UIButton!
    @IBOutlet weak var player3rollButton: UIButton!
    
    
    
    @IBOutlet weak var player1scoreLabel: UILabel!
    @IBOutlet weak var player1diceResult: UILabel!
    
    
    @IBOutlet weak var player2scoreLabel: UILabel!
    @IBOutlet weak var player2diceResult: UILabel!
    
    @IBOutlet weak var player3scoreLabel: UILabel!
    @IBOutlet weak var player3diceResult: UILabel!
    
    var diceNameArr = ["DICE1B", "DICE2B", "DICE3B", "DICE4B", "DICE5B", "DICE6B"]
    
    let numArray = [1, 2, 3, 4, 5, 6]
    var threeNumArr : [Int] = [0,0,0]
    
    
    var player1score : Int = 0
    var player2score : Int = 0
    var player3score : Int = 0
    
    var player1fourFiveSix = false
    var player2fourFiveSix = false
    var player3fourFiveSix = false
    
    var player1oneTwoThree = false
    var player2oneTwoThree = false
    var player3oneTwoThree = false
    
    var player1Triple = false
    var player2Triple = false
    var player3Triple = false
    
    var player1hasGone : Bool = false
    var player2hasGone : Bool = false
    var player3hasGone : Bool = false
    
    var randomIndexVar1 : Int?
    var randomIndexVar2 : Int?
    var randomIndexVar3 : Int?
    
    var minTurns = 0
    
    var gameDecided : Bool = false
    var message = ""
    var amtOfPlayersLeft : Int = 3
    var player1active = true
    var player2active = true
    var player3active = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dice1.image = UIImage(named: "DICE2B")
        dice2.image = UIImage(named: "DICE5B")
        dice3.image = UIImage(named: "DICE3B")
        player2rollButton.isEnabled = false
        player3rollButton.isEnabled = false
        player2rollButton.isHidden = true
        player3rollButton.isHidden = true
        betTextField.isEnabled = true
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let alertController = UIAlertController(title: "Wager entry", message: "Place a bet entry if playing to gamble next to bet label before rolling", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed okay");
        }
        
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        randomIndexVar1 = 2
        randomIndexVar2 = 2
        randomIndexVar3 = 2
        threeNumArr[0] = randomIndexVar1!
        threeNumArr[1] = randomIndexVar2!
        threeNumArr[2] = randomIndexVar3!
        UIUpdates(listofNums: threeNumArr)
    }
    
    func testPlayer2Roll()
    {
        randomIndexVar1 = 2
        randomIndexVar2 = 2
        randomIndexVar3 = 2
        threeNumArr[0] = randomIndexVar1!
        threeNumArr[1] = randomIndexVar2!
        threeNumArr[2] = randomIndexVar3!
        UIUpdates(listofNums: threeNumArr)
    }
    
    func testPlayer3Roll()
    {
        randomIndexVar1 = 1
        randomIndexVar2 = 5
        randomIndexVar3 = 5
        threeNumArr[0] = randomIndexVar1!
        threeNumArr[1] = randomIndexVar2!
        threeNumArr[2] = randomIndexVar3!
        UIUpdates(listofNums: threeNumArr)
    }
    
    
    func UIUpdates(listofNums : [Int])
    {
        dice1.image = UIImage(named: diceNameArr[threeNumArr[0]])
        dice2.image = UIImage(named: diceNameArr[threeNumArr[1]])
        dice3.image = UIImage(named: diceNameArr[threeNumArr[2]])
        print(diceNameArr[threeNumArr[0]])
        print(diceNameArr[threeNumArr[1]])
        print(diceNameArr[threeNumArr[2]])
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
        
        
        
        
        if(minTurns > 1000)
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
        
    
    
    
    @IBAction func player3rollButton(_ sender: UIButton)
    {
        if player3active == true
        {
            diceRoll()
            //testPlayer3Roll()
            while(player3hasGone == false)
            {
                if (dice2.image! != dice3.image! && dice1.image! != dice3.image! && dice1.image! != dice2.image!)
                {
                    if (diceNameArr[threeNumArr[0]] == "DICE4B" && diceNameArr[threeNumArr[1]] == "DICE5B" && diceNameArr[threeNumArr[2]] == "DICE6B" ||
                        diceNameArr[threeNumArr[0]] == "DICE4B" && diceNameArr[threeNumArr[1]] == "DICE6B" && diceNameArr[threeNumArr[2]] == "DICE5B" ||
                        diceNameArr[threeNumArr[0]] == "DICE5B" && diceNameArr[threeNumArr[1]] == "DICE4B" && diceNameArr[threeNumArr[2]] == "DICE6B" ||
                        diceNameArr[threeNumArr[0]] == "DICE5B" && diceNameArr[threeNumArr[1]] == "DICE6B" && diceNameArr[threeNumArr[2]] == "DICE4B" ||
                        diceNameArr[threeNumArr[0]] == "DICE6B" && diceNameArr[threeNumArr[1]] == "DICE4B" && diceNameArr[threeNumArr[2]] == "DICE5B" ||
                        diceNameArr[threeNumArr[0]] == "DICE6B" && diceNameArr[threeNumArr[1]] == "DICE5B" && diceNameArr[threeNumArr[2]] == "DICE4B")
                        {
                            amtOfPlayersLeft = amtOfPlayersLeft - 1
                            minTurns = 0
                            player3fourFiveSix = true
                            player3score = 6
                            player3scoreLabel.text = String(player3score)
                            player3diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                            player3rollButton.isEnabled = false
                            player3rollButton.isHidden = true
                            player3hasGone = true
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
                        amtOfPlayersLeft = amtOfPlayersLeft - 1
                        minTurns = 0
                        player3oneTwoThree = true
                        player3score = 0
                        player3scoreLabel.text = String(player3score)
                        player3diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                        player3rollButton.isEnabled = false
                        player3rollButton.isHidden = true
                        player3hasGone = true
                        //reloadInputViews()
                        print("here123")
                        checkWhoWon()
                        break
                    }
                    
                    player3rollButton.isEnabled = true
                    player3score = 0
                    player3scoreLabel.text = String(player3score)
                    player3hasGone = false
                    print("roll again")
                    break
                }
                
                else if (dice1.image! == dice2.image! && dice2.image! == dice3.image!)
                {
                    amtOfPlayersLeft = amtOfPlayersLeft - 1
                    minTurns = 0
                    player3Triple = true
                    player3score = Int(threeNumArr[0] + 1)
                    player3scoreLabel.text = String(player3score)
                    player3diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                    player3rollButton.isEnabled = false
                    player3rollButton.isHidden = true
                    player3hasGone = true
                    //reloadInputViews()
                    print("hereTriple2")
                    checkWhoWon()
                    break
                    
                }
                    
                else if (dice1.image! == dice2.image!)
                {
                    amtOfPlayersLeft = amtOfPlayersLeft - 1
                    minTurns = 0
                    player3score = Int(threeNumArr[2] + 1)
                    player3scoreLabel.text = String(player3score)
                    player3diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                    player3rollButton.isEnabled = false
                    player3rollButton.isHidden = true
                    player3hasGone = true
                    minTurns = 0
                    //reloadInputViews()
                    print("here 7")
                    print("Score :\(player3score)")
                    checkWhoWon()
                    break
                }
                    
                else if (dice1.image! == dice3.image!)
                {
                    amtOfPlayersLeft = amtOfPlayersLeft - 1
                    minTurns = 0
                    player3score = Int(threeNumArr[1] + 1)
                    player3scoreLabel.text = String(player3score)
                    player3diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                    player3rollButton.isEnabled = false
                    player3rollButton.isHidden = true
                    player3hasGone = true
                    //reloadInputViews()
                    print("here 8")
                    print("Score :\(player3score)")
                    checkWhoWon()
                    break
                    
                }
                    
                else if (dice2.image! == dice3.image!)
                {
                    amtOfPlayersLeft = amtOfPlayersLeft - 1
                    minTurns = 0
                    player3score = Int(threeNumArr[0] + 1)
                    player3scoreLabel.text = String(player3score)
                    player3diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                    player3rollButton.isEnabled = false
                    player3rollButton.isHidden = true
                    player3hasGone = true
                    //reloadInputViews()
                    print("here 9")
                    print("Score :\(player3score)")
                    checkWhoWon()
                    break
                    
                }
                
            }
            print("Player 3 has went ")
        }
        
    }
    
  
    
    
    @IBAction func player2rollButton(_ sender: UIButton)
    {
        if player2active == true
        {
        diceRoll()
        //testPlayer2Roll()
        while(player2hasGone == false)
        {
            if (dice2.image! != dice3.image! && dice1.image! != dice3.image! && dice1.image! != dice2.image!)
            {
                if (diceNameArr[threeNumArr[0]] == "DICE4B" && diceNameArr[threeNumArr[1]] == "DICE5B" && diceNameArr[threeNumArr[2]] == "DICE6B" ||
                    diceNameArr[threeNumArr[0]] == "DICE4B" && diceNameArr[threeNumArr[1]] == "DICE6B" && diceNameArr[threeNumArr[2]] == "DICE5B" ||
                    diceNameArr[threeNumArr[0]] == "DICE5B" && diceNameArr[threeNumArr[1]] == "DICE4B" && diceNameArr[threeNumArr[2]] == "DICE6B" ||
                    diceNameArr[threeNumArr[0]] == "DICE5B" && diceNameArr[threeNumArr[1]] == "DICE6B" && diceNameArr[threeNumArr[2]] == "DICE4B" ||
                    diceNameArr[threeNumArr[0]] == "DICE6B" && diceNameArr[threeNumArr[1]] == "DICE4B" && diceNameArr[threeNumArr[2]] == "DICE5B" ||
                    diceNameArr[threeNumArr[0]] == "DICE6B" && diceNameArr[threeNumArr[1]] == "DICE5B" && diceNameArr[threeNumArr[2]] == "DICE4B")
                {
                    amtOfPlayersLeft = amtOfPlayersLeft - 1
                    minTurns = 0
                    player2fourFiveSix = true
                    player2score = 6
                    player2scoreLabel.text = String(player2score)
                    player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                    player2rollButton.isEnabled = false
                    player2rollButton.isHidden = true
                    
                    if player3active == true
                    {
                        player3rollButton.isEnabled = true
                        player3rollButton.isHidden = false
                    }
                    
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
                    amtOfPlayersLeft = amtOfPlayersLeft - 1
                    minTurns = 0
                    player2oneTwoThree = true
                    player2score = 0
                    player2scoreLabel.text = String(player2score)
                    player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                    player2rollButton.isEnabled = false
                    player2rollButton.isHidden = true
                    
                    if player3active == true
                    {
                        player3rollButton.isEnabled = true
                        player3rollButton.isHidden = false
                    }
                    player2hasGone = true
                    //reloadInputViews()
                    print("here123")
                    checkWhoWon()
                    break
                }
                
                player2rollButton.isEnabled = true
                player2score = 0
                player2scoreLabel.text = String(player2score)
                player2hasGone = false
                print("roll again")
                break
            }
                
            else if (dice1.image! == dice2.image! && dice2.image! == dice3.image!)
            {
                amtOfPlayersLeft = amtOfPlayersLeft - 1
                minTurns = 0
                player2Triple = true
                player2score = Int(threeNumArr[0] + 1)
                player2scoreLabel.text = String(player2score)
                player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player2rollButton.isEnabled = false
                player2rollButton.isHidden = true
                
                if player3active == true
                {
                    player3rollButton.isEnabled = true
                    player3rollButton.isHidden = false
                }
                player2hasGone = true
                //reloadInputViews()
                print("hereTriple2")
                checkWhoWon()
                break
                
            }
                
            else if (dice1.image! == dice2.image!)
            {
                amtOfPlayersLeft = amtOfPlayersLeft - 1
                minTurns = 0
                player2score = Int(threeNumArr[2] + 1)
                player2scoreLabel.text = String(player2score)
                player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player2rollButton.isEnabled = false
                player2rollButton.isHidden = true
                
                if player3active == true
                {
                    player3rollButton.isEnabled = true
                    player3rollButton.isHidden = false
                }
                player2hasGone = true
                minTurns = 0
                //reloadInputViews()
                checkWhoWon()
                break
            }
                
            else if (dice1.image! == dice3.image!)
            {
                amtOfPlayersLeft = amtOfPlayersLeft - 1
                minTurns = 0
                player2score = Int(threeNumArr[1] + 1)
                player2scoreLabel.text = String(player2score)
                player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player2rollButton.isEnabled = false
                player2rollButton.isHidden = true
                
                if player3active == true
                {
                    player3rollButton.isEnabled = true
                    player3rollButton.isHidden = false
                }
                player2hasGone = true
                //reloadInputViews()
                checkWhoWon()
                break
                
            }
                
            else if (dice2.image! == dice3.image!)
            {
                amtOfPlayersLeft = amtOfPlayersLeft - 1
                minTurns = 0
                player2score = Int(threeNumArr[0] + 1)
                player2scoreLabel.text = String(player2score)
                player2diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                player2rollButton.isEnabled = false
                player2rollButton.isHidden = true
                
                if player3active == true
                {
                    player3rollButton.isEnabled = true
                    player3rollButton.isHidden = false
                }
                player2hasGone = true
                //reloadInputViews()
                checkWhoWon()
                break
                
            }
            
        }
            print("Player 2 has went ")
            
        }
    }
    
    
    
    
    @IBAction func player1rollButton(_ sender: UIButton)
    {
        if player1active == true
        {
            player1score = 0
            player2score = 0
            player3score = 0
            gameDecided = false
            submitButton.isEnabled = false
            resetButton.isEnabled = false
            diceRoll()
            //testPlayer1Roll()
            
            while(player1hasGone == false)
            {
                if (dice2.image! != dice3.image! && dice1.image! != dice3.image! && dice1.image! != dice2.image!)
                {
                    if (diceNameArr[threeNumArr[0]] == "DICE4B" && diceNameArr[threeNumArr[1]] == "DICE5B" && diceNameArr[threeNumArr[2]] == "DICE6B" ||
                        diceNameArr[threeNumArr[0]] == "DICE4B" && diceNameArr[threeNumArr[1]] == "DICE6B" && diceNameArr[threeNumArr[2]] == "DICE5B" ||
                        diceNameArr[threeNumArr[0]] == "DICE5B" && diceNameArr[threeNumArr[1]] == "DICE4B" && diceNameArr[threeNumArr[2]] == "DICE6B" ||
                        diceNameArr[threeNumArr[0]] == "DICE5B" && diceNameArr[threeNumArr[1]] == "DICE6B" && diceNameArr[threeNumArr[2]] == "DICE4B" ||
                        diceNameArr[threeNumArr[0]] == "DICE6B" && diceNameArr[threeNumArr[1]] == "DICE4B" && diceNameArr[threeNumArr[2]] == "DICE5B" ||
                        diceNameArr[threeNumArr[0]] == "DICE6B" && diceNameArr[threeNumArr[1]] == "DICE5B" && diceNameArr[threeNumArr[2]] == "DICE4B")
                    {
                        amtOfPlayersLeft = amtOfPlayersLeft - 1
                        minTurns = 0
                        player1fourFiveSix = true
                        player1score = 6
                        player1scoreLabel.text = String(player1score)
                        player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                        player1rollButton.isEnabled = false
                        player1rollButton.isHidden = true
                        
                        if player2active == true
                        {
                            player2rollButton.isEnabled = true
                            player2rollButton.isHidden = false
                        }
                        
                        if player2active == false && player3active == true
                        {
                            player3rollButton.isHidden = false
                            player3rollButton.isEnabled = true
                        }
                        
            
                        player1hasGone = true
                        //reloadInputViews()
                        print("here456")
                        //checkWhoWon()
                        break
                    }
                    
                    if (diceNameArr[threeNumArr[0]] == "DICE1B" && diceNameArr[threeNumArr[1]] == "DICE2B" && diceNameArr[threeNumArr[2]] == "DICE3B" ||
                        diceNameArr[threeNumArr[0]] == "DICE1B" && diceNameArr[threeNumArr[1]] == "DICE3B" && diceNameArr[threeNumArr[2]] == "DICE2B" ||
                        diceNameArr[threeNumArr[0]] == "DICE2B" && diceNameArr[threeNumArr[1]] == "DICE1B" && diceNameArr[threeNumArr[2]] == "DICE3B" ||
                        diceNameArr[threeNumArr[0]] == "DICE2B" && diceNameArr[threeNumArr[1]] == "DICE3B" && diceNameArr[threeNumArr[2]] == "DICE1B" ||
                        diceNameArr[threeNumArr[0]] == "DICE3B" && diceNameArr[threeNumArr[1]] == "DICE1B" && diceNameArr[threeNumArr[2]] == "DICE2B" ||
                        diceNameArr[threeNumArr[0]] == "DICE3B" && diceNameArr[threeNumArr[1]] == "DICE2B" && diceNameArr[threeNumArr[2]] == "DICE1B")
                    {
                        amtOfPlayersLeft = amtOfPlayersLeft - 1
                        minTurns = 0
                        player1oneTwoThree = true
                        player1score = 0
                        player1scoreLabel.text = String(player1score)
                        player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                        player1rollButton.isEnabled = false
                        player1rollButton.isHidden = true
                        
                        if player2active == true
                        {
                            player2rollButton.isEnabled = true
                            player2rollButton.isHidden = false
                        }
                        
                        if player2active == false && player3active == true
                        {
                            player3rollButton.isHidden = false
                            player3rollButton.isEnabled = true
                        }
                        
                        
                        player1hasGone = true
                        //reloadInputViews()
                        print("here123")
                        //checkWhoWon()
                        break
                    }
                    
                    player1rollButton.isEnabled = true
                    player1score = 0
                    player1scoreLabel.text = String(player1score)
                    player1hasGone = false
                    print("roll again")
                    break
                }
                    
                else if (dice1.image! == dice2.image! && dice2.image! == dice3.image!)
                {
                    amtOfPlayersLeft = amtOfPlayersLeft - 1
                    minTurns = 0
                    player1Triple = true
                    player1score = Int(threeNumArr[0] + 1)
                    player1scoreLabel.text = String(player1score)
                    player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                    player1rollButton.isEnabled = false
                    player1rollButton.isHidden = true
                    
                    if player2active == true
                    {
                        player2rollButton.isEnabled = true
                        player2rollButton.isHidden = false
                    }
                    
                    if player2active == false && player3active == true
                    {
                        player3rollButton.isHidden = false
                        player3rollButton.isEnabled = true
                    }
                    player1hasGone = true
                    //reloadInputViews()
                    print("hereTriple2")
                    //checkWhoWon()
                    break
                    
                }
                    
                else if (dice1.image! == dice2.image!)
                {
                    amtOfPlayersLeft = amtOfPlayersLeft - 1
                    minTurns = 0
                    player1score = Int(threeNumArr[2] + 1)
                    player1scoreLabel.text = String(player1score)
                    player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                    player1rollButton.isEnabled = false
                    player1rollButton.isHidden = true
                    
                    if player2active == true
                    {
                        player2rollButton.isEnabled = true
                        player2rollButton.isHidden = false
                    }
                    
                    if player2active == false && player3active == true
                    {
                        player3rollButton.isHidden = false
                        player3rollButton.isEnabled = true
                    }
                    
                    player1hasGone = true
                    //reloadInputViews()
                    break
                }
                    
                else if (dice1.image! == dice3.image!)
                {
                    amtOfPlayersLeft = amtOfPlayersLeft - 1
                    minTurns = 0
                    player1score = Int(threeNumArr[1] + 1)
                    player1scoreLabel.text = String(player1score)
                    player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                    player1rollButton.isEnabled = false
                    player1rollButton.isHidden = true
                    
                    if player2active == true
                    {
                        player2rollButton.isEnabled = true
                        player2rollButton.isHidden = false
                    }
                    
                    if player2active == false && player3active == true
                    {
                        player3rollButton.isHidden = false
                        player3rollButton.isEnabled = true
                    }
                    player1hasGone = true
                    //reloadInputViews()
                    break
                    
                }
                    
                else if (dice2.image! == dice3.image!)
                {
                    amtOfPlayersLeft = amtOfPlayersLeft - 1
                    minTurns = 0
                    player1score = Int(threeNumArr[0] + 1)
                    player1scoreLabel.text = String(player1score)
                    player1diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
                    player1rollButton.isEnabled = false
                    player1rollButton.isHidden = true
                    
                    
                    if player2active == true
                    {
                        player2rollButton.isEnabled = true
                        player2rollButton.isHidden = false
                    }
                    
                    if player2active == false && player3active == true
                    {
                        player3rollButton.isHidden = false
                        player3rollButton.isEnabled = true
                    }
                    player1hasGone = true
                    //reloadInputViews()
                    break
                    
                }
                
            }
            print("Player 1 has went ")
            
            
            
            }
    }
    
    
    public func resetEverythingP1nP2()
    {
        
        player1diceResult.text = "0-0-0"
        player2diceResult.text = "0-0-0"
        player1score = 0
        player2score = 0
        player3score = 0
        player1scoreLabel.text = "0"
        player2scoreLabel.text = "0"
        randomIndexVar1 = 0
        randomIndexVar2 = 0
        randomIndexVar3 = 0
        player1rollButton.isHidden = false
        player1rollButton.isEnabled = false
        player1oneTwoThree = false
        player2oneTwoThree = false
        player1fourFiveSix = false
        player2fourFiveSix = false
        player1Triple = false
        player2Triple = false
        gameDecided = false
        minTurns = 0
        threeNumArr = [0,0,0]
        player1active = true
        player1hasGone = false
        player2active = true
        player2hasGone = false
        
    }
    
    public func resetEverythingP1nP3()
    {
        player1diceResult.text = "0-0-0"
        player3diceResult.text = "0-0-0"
        player1score = 0
        player2score = 0
        player3score = 0
        player1scoreLabel.text = "0"
        player3scoreLabel.text = "0"
        randomIndexVar1 = 0
        randomIndexVar2 = 0
        randomIndexVar3 = 0
        player1rollButton.isHidden = false
        player1rollButton.isEnabled = false
        player1oneTwoThree = false
        player3oneTwoThree = false
        player1fourFiveSix = false
        player3fourFiveSix = false
        player1Triple = false
        player3Triple = false
        gameDecided = false
        minTurns = 0
        threeNumArr = [0,0,0]
        player1active = true
        player1hasGone = false
        player3active = true
        player3hasGone = false
    }
    
    public func resetEverythingP2nP3()
    {
        player2diceResult.text = "0-0-0"
        player3diceResult.text = "0-0-0"
        player1score = 0
        player2score = 0
        player3score = 0
        player2scoreLabel.text = "0"
        player3scoreLabel.text = "0"
        randomIndexVar1 = 0
        randomIndexVar2 = 0
        randomIndexVar3 = 0
        player2rollButton.isHidden = false
        player2rollButton.isEnabled = false
        player2oneTwoThree = false
        player3oneTwoThree = false
        player2fourFiveSix = false
        player3fourFiveSix = false
        player2Triple = false
        player3Triple = false
        gameDecided = false
        minTurns = 0
        threeNumArr = [0,0,0]
        player2active = true
        player2hasGone = false
        player3active = true
        player3hasGone = false
    }
    
    public func resetEverythingButBetAmt()
    {
        player1diceResult.text = "0-0-0"
        player2diceResult.text = "0-0-0"
        player3diceResult.text = "0-0-0"
        player1score = 0
        player2score = 0
        player3score = 0
        player1scoreLabel.text = "0"
        player2scoreLabel.text = "0"
        player3scoreLabel.text = "0"
        player3oneTwoThree = false
        player2oneTwoThree = false
        player1oneTwoThree = false
        player3fourFiveSix = false
        player2fourFiveSix = false
        player1fourFiveSix = false
        player1Triple = false
        player2Triple = false
        player3Triple = false
        randomIndexVar1 = 0
        randomIndexVar2 = 0
        randomIndexVar3 = 0
        gameDecided = false
        minTurns = 0
        threeNumArr = [0,0,0]
        player1hasGone = false
        player2hasGone = false
        player3hasGone = false
    }
    
    
    
    public func resetEverything()
    {
        player1rollButton.isEnabled = true
        player1diceResult.text = "0-0-0"
        player2diceResult.text = "0-0-0"
        player3diceResult.text = "0-0-0"
        player1score = 0
        player2score = 0
        player3score = 0
        player1scoreLabel.text = "0"
        player2scoreLabel.text = "0"
        player3scoreLabel.text = "0"
        player3oneTwoThree = false
        player2oneTwoThree = false
        player1oneTwoThree = false
        player3fourFiveSix = false
        player2fourFiveSix = false
        player1fourFiveSix = false
        player1Triple = false
        player2Triple = false
        player3Triple = false
        randomIndexVar1 = 0
        randomIndexVar2 = 0
        randomIndexVar3 = 0
        gameDecided = false
        minTurns = 0
        threeNumArr = [0,0,0]
        player1hasGone = false
        player2hasGone = false
        player3hasGone = false
        submitButton.isEnabled = true
        resetButton.isEnabled = true
        betLabel.text = ""
        betTextField.text = ""
        betTextField.isHidden = false
        betTextField.isEnabled = true
    }
    
    
    func checkWhoWon()
    {
        while(gameDecided == false && amtOfPlayersLeft == 0)
        {
            //all players have 456
            if (player1fourFiveSix == true && player2fourFiveSix == true && player3fourFiveSix == true)
            {
                //Animation for tie here
                message = "Three way tie, everyone collects"
                print("Three way tie456")
                gameDecided = true
                gameTied()
                amtOfPlayersLeft = 3
                player1rollButton.isEnabled = true
                player2rollButton.isEnabled = false
                player3rollButton.isEnabled = false
                break
            }
            
            //player1,2 have 456
            else if (player1fourFiveSix == true && player2fourFiveSix == true && player3fourFiveSix == false)
            {
                //Animation for tie here
                message = "Two way tie, you have the option to split winnings or quit game and choose 2 player option and go for it all"
                print("Two way tie456 player12")
                gameDecided = true
                gameTied12()
                amtOfPlayersLeft = 2
                player1rollButton.isEnabled = true
                player2rollButton.isEnabled = false
                break
            }
            
            //player1,3 have 456
            else if (player1fourFiveSix == true && player2fourFiveSix == false && player3fourFiveSix == true)
            {
                //Animation for tie here
                message = "Two way tie, you have the option to split winnings or quit game and choose 2 player option and go for it all"
                print("Two way tie456 player13")
                gameDecided = true
                gameTied13()
                amtOfPlayersLeft = 2
                player1rollButton.isEnabled = true
                player3rollButton.isEnabled = false
                break
            }
            
            //player2,3 have 456
            else if (player1fourFiveSix == false && player2fourFiveSix == true && player3fourFiveSix == true)
            {
                //Animation for tie here
                message = "Two way tie, you have the option to split winnings or quit game and choose 2 player option and go for it all"
                print("Two way tie456 player23")
                gameDecided = true
                gameTied23()
                amtOfPlayersLeft = 2
                player2rollButton.isEnabled = true
                player3rollButton.isEnabled = false
                break
            }
            
            //player2 has 456
            else if (player1fourFiveSix == false && player2fourFiveSix == true && player3fourFiveSix == false)
            {
                //Animation for win here
                message = "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                print("player 2 has won")
                gameDecided = true
                gameCompleted()
                break
            }
            
            //player1 has 456
            else if (player1fourFiveSix == true && player2fourFiveSix == false && player3fourFiveSix == false)
            {
                //Animation for win here
                message = "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                print("player 1 has won")
                gameDecided = true
                gameCompleted()
                break
            }
                
        
            //player3 has 456
            else if (player1fourFiveSix == false && player2fourFiveSix == false && player3fourFiveSix == true)
            {
                //Animation for win here
                message = "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)"
                print("player 3 has won")
                gameDecided = true
                gameCompleted()
                break
            }
        
                
            //player1 has triple
            else if (player1Triple == true && player2Triple == false && player3Triple == false)
            {
                //Animation for win here
                message = "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                print("player 1 has won")
                gameDecided = true
                gameCompleted()
                break
            }
            
            //player2 has triple
            else if (player1Triple == false && player2Triple == true && player3Triple == false)
            {
                //Animation for win here
                message = "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                print("player 2 has won")
                gameDecided = true
                gameCompleted()
                break
            }
            
            //player3 has triple
            else if (player1Triple == false && player2Triple == false && player3Triple == true)
            {
                //Animation for win here
                message = "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)"
                print("player 3 has won")
                gameDecided = true
                gameCompleted()
                break
            }
            
            //all players have triple
            else if(player1Triple == true && player2Triple == true && player3Triple == true)
            {
                if(player1score > player2score && player2score >= player3score || player1score > player3score && player3score >= player2score)
                {
                    //Animation for win here
                    message = "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                    print("player 1 has won")
                    gameDecided = true
                    gameCompleted()
                    break
                }
                else if (player2score > player1score && player1score >= player3score || player2score > player3score && player3score >= player1score)
                {
                    //Animation for win here
                    message = "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                    print("player 2 has won")
                    gameDecided = true
                    gameCompleted()
                    break
                }
                
                
                else if (player3score > player1score && player1score >= player2score || player3score > player2score && player2score >= player1score)
                {
                    //Animation for win here
                    message = "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)"
                    print("player 3 has won")
                    gameDecided = true
                    gameCompleted()
                    break
                }
            }
            
            //Player12 have triple
            else if(player1Triple == true && player2Triple == true && player3Triple == false)
            {
                if (player1score > player2score)
                {
                    //Animation for win here
                    message = "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                    print("player 1 has won")
                    gameDecided = true
                    gameCompleted()
                    break
                }
                
                else if (player2score > player1score)
                {
                    //Animation for win here
                    message = "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                    print("player 2 has won")
                    gameDecided = true
                    gameCompleted()
                    break
                }
                
                else if (player2score == player1score)
                {
                    //Animation for tie here
                    message = "Two way tie, you have the option to split winnings or quit game and choose 2 player option and go for it all"
                    print("Two way tieTriple player12")
                    gameDecided = true
                    gameTied12()
                    amtOfPlayersLeft = 2
                    player1rollButton.isEnabled = true
                    player2rollButton.isEnabled = false
                    break
                }
                
            }
            
             //player13 have triple
            else if(player1Triple == true && player2Triple == false && player3Triple == true)
            {
                if (player1score > player3score)
                {
                    message = "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                    print("player 1 has won")
                    gameDecided = true
                    gameCompleted()
                    break
                }
                    
                else if (player3score > player1score)
                {
                    message = "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)"
                    print("player 3 has won")
                    gameDecided = true
                    gameCompleted()
                    break
                }
                    
                else if (player3score == player1score)
                {
                    message = "Two way tie, you have the option to split winnings or quit game and choose 2 player option and go for it all"
                    print("Two way tieTriple player13")
                    gameDecided = true
                    gameTied13()
                    amtOfPlayersLeft = 2
                    player1rollButton.isEnabled = true
                    player3rollButton.isEnabled = false
                    break
                }
                
            }
            
            //player23 have triple
            else if(player1Triple == false && player2Triple == true && player3Triple == true)
            {
                if (player2score > player3score)
                {
                    message = "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                    print("player 2 has won")
                    gameDecided = true
                    gameCompleted()
                    break
                }
                    
                else if (player3score > player2score)
                {
                    message = "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)"
                    print("player 3 has won")
                    gameDecided = true
                    gameCompleted()
                    break
                }
                    
                else if (player2score == player3score)
                {
                    message = "Two way tie, you have the option to split winnings or quit game and choose 2 player option and go for it all"
                    print("Two way tieTriple player23")
                    gameDecided = true
                    gameTied()
                    player2rollButton.isEnabled = true
                    player3rollButton.isEnabled = false
                    break
                }
                
            }
                
            
            //player 1 wins
            else if(player1score > player2score && player2score >= player3score || player1score > player3score && player3score >= player2score)
            {
                message = "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)"
                print("player 1 has won")
                gameDecided = true
                gameCompleted()
                break
            }
                
            //player 2 wins
            else if(player2score > player1score && player1score >= player3score || player2score > player3score && player3score >= player1score)
            {
                message = "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)"
                print("player 2 has won")
                gameDecided = true
                gameCompleted()
                break
            }
             
            //player 3 wins
            else if(player3score > player1score && player1score >= player2score || player3score > player2score && player2score >= player1score)
            {
                message = "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)"
                print("player 3 has won")
                gameDecided = true
                gameCompleted()
                break
            }
            
            //player1,2 tie for win
            else if(player1score == player2score && player2score > player3score)
            {
                message = "Two way tie, you have the option to split winnings or quit game and choose 2 player option and go for it all"
                print("Two way tieScore player12")
                gameDecided = true
                gameTied12()
                amtOfPlayersLeft = 2
                player1rollButton.isEnabled = true
                player2rollButton.isEnabled = true
                break
            }
            
            //player2,3 tie for win
            else if(player2score == player3score && player3score > player1score)
            {
                message = "Two way tie, you have the option to split winnings or quit game and choose 2 player option and go for it all"
                print("Two way tieScore player23")
                gameDecided = true
                gameTied23()
                amtOfPlayersLeft = 2
                player2rollButton.isEnabled = true
                player3rollButton.isEnabled = false
                break
            }
            
            //player1,3 tie for win 
            else if(player1score == player3score && player3score > player2score)
            {
                message = "Two way tie, you have the option to split winnings or quit game and choose 2 player option and go for it all"
                print("Two way tieScore player13")
                gameDecided = true
                gameTied13()
                amtOfPlayersLeft = 2
                player1rollButton.isEnabled = true
                player3rollButton.isEnabled = false 
                break
                
            }
            
            
            
            
        }
      
    }
    
   
    func gameCompleted()
    {
        let alertController = UIAlertController(title: "Game complete", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Run it back?", style: .default) { (action:UIAlertAction) in
            self.resetEverything()
            self.performSegue(withIdentifier: "runItBack", sender: self)
            
            print("You've pressed default");
        }
        let action2 = UIAlertAction(title: "Quit game", style: .default)
        { (action: UIAlertAction) in
            self.resetEverything()
            self.performSegue(withIdentifier: "moveToGame", sender: self)
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
            self.performSegue(withIdentifier: "moveToGame", sender: self)
            print("quit game")
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func gameTied12()
    {
        print("Game is tied")
        let alertController = UIAlertController(title: "Game complete", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Run it back?", style: .default) { (action:UIAlertAction) in
            self.resetEverythingP1nP2()
            print("You've run it back");
        }
        let action2 = UIAlertAction(title: "Quit game", style: .default)
        { (action: UIAlertAction) in
            self.resetEverything()
            self.performSegue(withIdentifier: "moveToGame", sender: self)
            print("quit game")
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func gameTied13()
    {
        print("Game is tied")
        let alertController = UIAlertController(title: "Game complete", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Run it back?", style: .default) { (action:UIAlertAction) in
            self.resetEverythingP1nP3()
            print("You've run it back");
        }
        let action2 = UIAlertAction(title: "Quit game", style: .default)
        { (action: UIAlertAction) in
            self.resetEverything()
            self.performSegue(withIdentifier: "moveToGame", sender: self)
            print("quit game")
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func gameTied23()
    {
        print("Game is tied")
        let alertController = UIAlertController(title: "Game complete", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Run it back?", style: .default) { (action:UIAlertAction) in
            self.resetEverythingP2nP3()
            print("You've run it back");
        }
        let action2 = UIAlertAction(title: "Quit game", style: .default)
        { (action: UIAlertAction) in
            self.resetEverything()
            self.performSegue(withIdentifier: "moveToGame", sender: self)
            print("quit game")
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton)
    {
        betLabel.text! = betTextField.text!
        betTextField.isHidden = true
        betTextField.isEnabled = false
        betLabel.isEnabled = true
        betLabel.isHidden = false
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton)
    {
        betTextField.isHidden = false
        betLabel.isHidden = true
        betTextField.isEnabled = true
        betTextField.text = ""
        betLabel.text = ""
    }
    

}