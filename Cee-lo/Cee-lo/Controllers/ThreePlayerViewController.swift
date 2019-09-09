//
//  ThreePlayerViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-04-23.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit
import AVFoundation

class ThreePlayerViewController: UIViewController, UITextFieldDelegate {

    //Necessary audio players for sounds required in game
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var audioPlayer3 = AVAudioPlayer()
    var audioPlayer4 = AVAudioPlayer()
   
    //On screen outlets
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var resultImage: UIImageView!
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
    
    
    //Necessary arrays for getting images
    var diceNameArr = ["DICE1B", "DICE2B", "DICE3B", "DICE4B", "DICE5B", "DICE6B"]
    var threeNumArr : [Int] = [0,0,0]
    
    //Varible which holds players scores
    var player1score : Int = 0
    var player2score : Int = 0
    var player3score : Int = 0
    
    //Variable to know whether or not player got 4-5-6 in any form
    var player1fourFiveSix = false
    var player2fourFiveSix = false
    var player3fourFiveSix = false
    
    //Variable to know whether or not player got 1-2-3 in any form
    var player1oneTwoThree = false
    var player2oneTwoThree = false
    var player3oneTwoThree = false
    
    //Variable to know whether or not player got triple in any form
    var player1Triple = false
    var player2Triple = false
    var player3Triple = false
    
    //If player has gone or not
    var player1hasGone : Bool = false
    var player2hasGone : Bool = false
    var player3hasGone : Bool = false
    
    //Variables that help with the randomization of the on dice screen
    var randomIndexVar1 : Int?
    var randomIndexVar2 : Int?
    var randomIndexVar3 : Int?
    
    var minTurns = 0
    
    //If the game is finished
    var gameDecided : Bool = false
    
    //Message that will be used in the alert controller
    var message = ""
    
    //Amount of players still playing the game
    var amtOfPlayersLeft : Int = 3
    
    //Players active in the game
    var player1active = true
    var player2active = true
    var player3active = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Gives the dice images a non-winning combination on-screen to start
        dice1.image = UIImage(named: "DICE2B")
        dice2.image = UIImage(named: "DICE5B")
        dice3.image = UIImage(named: "DICE3B")
        
        //Assign the textField delegate to this class
        betTextField.delegate = self
        
        //Hide and deactivate the player2rollButton and player3rollButton
        player2rollButton.isEnabled = false
        player3rollButton.isEnabled = false
        player2rollButton.isHidden = true
        player3rollButton.isHidden = true
        betTextField.isEnabled = true
        
        
        //Adding the sounds to this view controller
        let sound = Bundle.main.path(forResource: "diceRollingSound", ofType: "mp3")
        let sound2 = Bundle.main.path(forResource: "123sound", ofType: "mp3")
        let sound3 = Bundle.main.path(forResource: "456sound", ofType: "mp3")
        let sound4 = Bundle.main.path(forResource: "winningSound2", ofType: "mp3")
        
        //Multiple do-catch loops to let the audio players be used
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
        catch
        {
            print(error)
        }
        
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2!))
        }
        catch
        {
            print(error)
        }
        
        do {
            audioPlayer3 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound3!))
        }
        catch{
            print(error)
        }
        do {
            audioPlayer4 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound4!))
        }
        catch{
            print(error)
        }
    
        
    }
    
    //These two functions should make the keyboard appear and disappear
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //After view is loaded an alert comes to the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        betTextField.becomeFirstResponder()
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
    
    
    func disableRolling()
    {
        player1rollButton.isEnabled = false
        player2rollButton.isEnabled = false
        player3rollButton.isEnabled = false
        
    }
    
    //Responsible for changing the images on screen
    func changeImage()
    {
        dice1.image = UIImage(named: self.diceNameArr[Int(arc4random_uniform (UInt32(self.diceNameArr.count)))])
        dice2.image = UIImage(named: self.diceNameArr[Int(arc4random_uniform (UInt32(self.diceNameArr.count)))])
        dice3.image = UIImage(named: self.diceNameArr[Int(arc4random_uniform (UInt32(self.diceNameArr.count)))])
    }
    
    //Helps change the images in delayed segments after the user presses the roll button
    func randomImageFirst()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2)
        {
            self.disableRolling()
            self.changeImage()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4)
        {
            self.disableRolling()
            self.changeImage()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)
        {
            self.disableRolling()
            self.changeImage()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8)
        {
            self.disableRolling()
            self.changeImage()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
        {
            self.disableRolling()
            self.changeImage()
        }

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

    func testPlayer3Roll()
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
    
    //Main function of what is done when the player presses roll button
    func diceRoll()
    {
        //Makes sure no one can press roll immediately after they already have
        disableRolling()
    
        //List of array indices which would generate non winning scores
        let listOfNonWinningScores = ["013", "014", "015", "023", "024", "025", "031", "032", "034", "035", "041", "042", "043", "045", "051", "052", "053","054","103", "104", "105", "123", "124", "125", "130", "132", "134", "135", "140", "142", "143", "145", "150", "152", "153", "154","203", "204", "205", "213", "214", "215", "230", "231", "234", "235", "240", "241", "243", "245", "250", "251", "253", "254", "301", "302", "304", "305", "310", "312", "314", "315", "320", "321", "324", "325", "340", "341", "342", "350", "351", "352", "401", "402", "403", "405", "410", "412", "413", "415", "420", "421", "423", "425", "430", "431", "432", "450", "451", "452", "501", "502", "503", "504", "510", "512", "513", "514", "520", "521", "523", "524", "530", "531", "532", "540", "541", "542"]
        
        //List of array indices which would generate winning scores
        var listofPossibleScores = ["000", "001", "002", "003", "004", "005", "010", "011", "012", "020", "021", "022", "030", "033", "040", "044", "050", "055",
                                    "100", "101", "102", "110", "111", "112", "113", "114,", "115", "120", "121", "122", "131", "133", "141", "144", "151", "155",
                                    "200", "201", "202", "210", "211", "212", "220", "221", "222", "223", "224", "225", "232", "233", "242", "244", "252", "255",
                                    "300", "303", "311", "313", "322", "323", "330", "331", "332", "333", "334", "335", "343", "344", "353", "355",
                                    "400", "404", "411", "414", "422", "424", "433", "434", "440", "441", "442", "443", "444" , "445", "454", "455",
                                    "500", "505", "511", "515", "522", "535", "533", "535", "544", "545", "550", "551", "552", "553", "554", "555"]
     
            //Combining the two arrays; initally was going to have a turn restriction before you could get a winning score
            listofPossibleScores.append(contentsOf: listOfNonWinningScores)
        
            //Random number chosen from the newly combined array
            let randomNum2 = listofPossibleScores[Int(arc4random_uniform((UInt32(listofPossibleScores.count))))]
        
            //startIndex2, inbetween2, lastNum2 each represent a number
            let startIndex2 = randomNum2[randomNum2.startIndex]
            print(startIndex2)
            
            let inBetween2 = randomNum2.index(after: randomNum2.startIndex)
            print(randomNum2[inBetween2])
            
            let lastNum2 = randomNum2.index(before: randomNum2.endIndex)
            print(randomNum2[lastNum2])
        
            //Casting startIndex2, inbetween2, lastNum2 from a string to a number
            //Then placing them in our threeNumArr so that it can be passed to UIUpdates
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
            threeNumArr[0] = randomIndexVar1!
            threeNumArr[1] = randomIndexVar2!
            threeNumArr[2] = randomIndexVar3!
            UIUpdates(listofNums: threeNumArr)
        
        
    }
        
    
    
    
    @IBAction func player3rollButton(_ sender: UIButton)
    {
        audioPlayer.play()
        if player3active == true
        {
            randomImageFirst()
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)
            {
                self.diceRoll()
            //testPlayer3Roll()
                while(self.player3hasGone == false)
            {
                if (self.dice2.image! != self.dice3.image! && self.dice1.image! != self.dice3.image! && self.dice1.image! != self.dice2.image!)
                {
                    if (self.diceNameArr[self.threeNumArr[0]] == "DICE4B" && self.diceNameArr[self.threeNumArr[1]] == "DICE5B" && self.diceNameArr[self.threeNumArr[2]] == "DICE6B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE4B" && self.diceNameArr[self.threeNumArr[1]] == "DICE6B" && self.diceNameArr[self.threeNumArr[2]] == "DICE5B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE5B" && self.diceNameArr[self.threeNumArr[1]] == "DICE4B" && self.diceNameArr[self.threeNumArr[2]] == "DICE6B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE5B" && self.diceNameArr[self.threeNumArr[1]] == "DICE6B" && self.diceNameArr[self.threeNumArr[2]] == "DICE4B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE6B" && self.diceNameArr[self.threeNumArr[1]] == "DICE4B" && self.diceNameArr[self.threeNumArr[2]] == "DICE5B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE6B" && self.diceNameArr[self.threeNumArr[1]] == "DICE5B" && self.diceNameArr[self.threeNumArr[2]] == "DICE4B")
                        {
                            self.audioPlayer3.play()
                            self.player3fourFiveSix = true
                            self.dicePlayer3MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: nil, playerScore: 6)
                            break
                        }
                    
                    if (self.diceNameArr[self.threeNumArr[0]] == "DICE1B" && self.diceNameArr[self.threeNumArr[1]] == "DICE2B" && self.diceNameArr[self.threeNumArr[2]] == "DICE3B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE1B" && self.diceNameArr[self.threeNumArr[1]] == "DICE3B" && self.diceNameArr[self.threeNumArr[2]] == "DICE2B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE2B" && self.diceNameArr[self.threeNumArr[1]] == "DICE1B" && self.diceNameArr[self.threeNumArr[2]] == "DICE3B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE2B" && self.diceNameArr[self.threeNumArr[1]] == "DICE3B" && self.diceNameArr[self.threeNumArr[2]] == "DICE1B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE3B" && self.diceNameArr[self.threeNumArr[1]] == "DICE1B" && self.diceNameArr[self.threeNumArr[2]] == "DICE2B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE3B" && self.diceNameArr[self.threeNumArr[1]] == "DICE2B" && self.diceNameArr[self.threeNumArr[2]] == "DICE1B")
                    {
                        self.audioPlayer2.play()
                        self.player3oneTwoThree = true
                        self.dicePlayer3MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: nil, playerScore: 0)
                        break
                    }
                    
                    self.player3rollButton.isEnabled = true
                    self.player3score = 0
                    self.player3scoreLabel.text = String(self.player3score)
                    self.player3hasGone = false
                    print("roll again")
                    break
                }
                
                else if (self.dice1.image! == self.dice2.image! && self.dice2.image! == self.dice3.image!)
                {
                    print("here6")
                    self.player3Triple = true
                    self.dicePlayer3MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 0, playerScore: nil)
                    break
                    
                }
                    
                else if (self.dice1.image! == self.dice2.image!)
                {
                    print("here 7")
                    self.dicePlayer3MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 2, playerScore: nil)
                    break
                }
                    
                else if (self.dice1.image! == self.dice3.image!)
                {
                    print("here 8")
                    self.dicePlayer3MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 1, playerScore: nil)
                    break
                    
                }
                    
                else if (self.dice2.image! == self.dice3.image!)
                {
                    print("here 9")
                    self.dicePlayer3MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 0, playerScore: nil)
                    break
                    
                }
                
            }
            print("Player 3 has went ")
            }
        }
        
    }
    
  
    
    
    @IBAction func player2rollButton(_ sender: UIButton)
    {
        if player2active == true
        {
            audioPlayer.play()
        randomImageFirst()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)
            {
                self.diceRoll()
                while(self.player2hasGone == false)
        {
            if (self.dice2.image! != self.dice3.image! && self.dice1.image! != self.dice3.image! && self.dice1.image! != self.dice2.image!)
            {
                if (self.diceNameArr[self.threeNumArr[0]] == "DICE4B" && self.diceNameArr[self.threeNumArr[1]] == "DICE5B" && self.diceNameArr[self.threeNumArr[2]] == "DICE6B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE4B" && self.diceNameArr[self.threeNumArr[1]] == "DICE6B" && self.diceNameArr[self.threeNumArr[2]] == "DICE5B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE5B" && self.diceNameArr[self.threeNumArr[1]] == "DICE4B" && self.diceNameArr[self.threeNumArr[2]] == "DICE6B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE5B" && self.diceNameArr[self.threeNumArr[1]] == "DICE6B" && self.diceNameArr[self.threeNumArr[2]] == "DICE4B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE6B" && self.diceNameArr[self.threeNumArr[1]] == "DICE4B" && self.diceNameArr[self.threeNumArr[2]] == "DICE5B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE6B" && self.diceNameArr[self.threeNumArr[1]] == "DICE5B" && self.diceNameArr[self.threeNumArr[2]] == "DICE4B")
                {
                    self.audioPlayer3.play()
                    self.player2fourFiveSix = true
                    self.dicePlayer2MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: nil, playerScore: 6)
                    break
                }
                
                if (self.diceNameArr[self.threeNumArr[0]] == "DICE1B" && self.diceNameArr[self.threeNumArr[1]] == "DICE2B" && self.diceNameArr[self.threeNumArr[2]] == "DICE3B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE1B" && self.diceNameArr[self.threeNumArr[1]] == "DICE3B" && self.diceNameArr[self.threeNumArr[2]] == "DICE2B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE2B" && self.diceNameArr[self.threeNumArr[1]] == "DICE1B" && self.diceNameArr[self.threeNumArr[2]] == "DICE3B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE2B" && self.diceNameArr[self.threeNumArr[1]] == "DICE3B" && self.diceNameArr[self.threeNumArr[2]] == "DICE1B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE3B" && self.diceNameArr[self.threeNumArr[1]] == "DICE1B" && self.diceNameArr[self.threeNumArr[2]] == "DICE2B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE3B" && self.diceNameArr[self.threeNumArr[1]] == "DICE2B" && self.diceNameArr[self.threeNumArr[2]] == "DICE1B")
                {
                    self.audioPlayer2.play()
                    self.player2oneTwoThree = true
                    self.dicePlayer2MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: nil, playerScore: 0)
                    break
                }
                
                self.player2rollButton.isEnabled = true
                self.player2score = 0
                self.player2scoreLabel.text = String(self.player2score)
                self.player2hasGone = false
                print("roll again")
                break
            }
                
            else if (self.dice1.image! == self.dice2.image! && self.dice2.image! == self.dice3.image!)
            {
                self.player2Triple = true
                self.dicePlayer2MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 0, playerScore: nil)
                break
                
            }
                
            else if (self.dice1.image! == self.dice2.image!)
            {
                self.dicePlayer2MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 2, playerScore: nil)
                break
            }
                
            else if (self.dice1.image! == self.dice3.image!)
            {
                self.dicePlayer2MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 1, playerScore: nil)
                break
                
            }
                
            else if (self.dice2.image! == self.dice3.image!)
            {
                self.dicePlayer2MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 0, playerScore: nil)
                break
                
            }
            
        }
            print("Player 2 has went ")
            
        }
        }
    }
    
    
    
    
    @IBAction func player1rollButton(_ sender: UIButton)
    {
        if player1active == true
        {
            //The sound of dice rolling
            audioPlayer.play()
            
            //whether or not the person uses the submit button to enter bet if there is anything inside the textfield it will become the bet
            betLabel.text! = betTextField.text!
            
            //Disables the betTextField so that it can't be clicked on mid game and hides it
            betTextField.isHidden = true
            betTextField.isEnabled = false
            
            //Contents of the betLabel are taken from betTextField and displayed
            betLabel.isHidden = false
            betLabel.isEnabled = true
            
            //Game not decided yet
            gameDecided = false
            
            //Disables these buttons so that the wager can't be altered or inputted after the game beings
            submitButton.isEnabled = false
            resetButton.isEnabled = false
            
            //Launches the randomImageFirst method to get the dice rolling animation
            randomImageFirst()
            
            //Delayed part executed after 1.2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)
            {
                //The dice roll which will determine whether the score for the player
                self.diceRoll()
            
                while(self.player1hasGone == false)
            {
                if (self.dice2.image! != self.dice3.image! && self.dice1.image! != self.dice3.image! && self.dice1.image! != self.dice2.image!)
                {
                    if (self.diceNameArr[self.threeNumArr[0]] == "DICE4B" && self.diceNameArr[self.threeNumArr[1]] == "DICE5B" && self.diceNameArr[self.threeNumArr[2]] == "DICE6B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE4B" && self.diceNameArr[self.threeNumArr[1]] == "DICE6B" && self.diceNameArr[self.threeNumArr[2]] == "DICE5B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE5B" && self.diceNameArr[self.threeNumArr[1]] == "DICE4B" && self.diceNameArr[self.threeNumArr[2]] == "DICE6B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE5B" && self.diceNameArr[self.threeNumArr[1]] == "DICE6B" && self.diceNameArr[self.threeNumArr[2]] == "DICE4B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE6B" && self.diceNameArr[self.threeNumArr[1]] == "DICE4B" && self.diceNameArr[self.threeNumArr[2]] == "DICE5B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE6B" && self.diceNameArr[self.threeNumArr[1]] == "DICE5B" && self.diceNameArr[self.threeNumArr[2]] == "DICE4B")
                    {
                        //Launches the special sound for 4-5-6
                        self.audioPlayer3.play()
                        self.player1fourFiveSix = true
                        print("here456")
                        self.dicePlayer1MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: nil, playerScore: 6)
                        //checkWhoWon()
                        break
                    }
                    
                    if (self.diceNameArr[self.threeNumArr[0]] == "DICE1B" && self.diceNameArr[self.threeNumArr[1]] == "DICE2B" && self.diceNameArr[self.threeNumArr[2]] == "DICE3B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE1B" && self.diceNameArr[self.threeNumArr[1]] == "DICE3B" && self.diceNameArr[self.threeNumArr[2]] == "DICE2B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE2B" && self.diceNameArr[self.threeNumArr[1]] == "DICE1B" && self.diceNameArr[self.threeNumArr[2]] == "DICE3B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE2B" && self.diceNameArr[self.threeNumArr[1]] == "DICE3B" && self.diceNameArr[self.threeNumArr[2]] == "DICE1B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE3B" && self.diceNameArr[self.threeNumArr[1]] == "DICE1B" && self.diceNameArr[self.threeNumArr[2]] == "DICE2B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE3B" && self.diceNameArr[self.threeNumArr[1]] == "DICE2B" && self.diceNameArr[self.threeNumArr[2]] == "DICE1B")
                    {
                        self.audioPlayer2.play()
                        self.player1oneTwoThree = true
                        self.player1score = 0
                
                        print("here123")
                        //checkWhoWon()
                        self.dicePlayer1MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: nil, playerScore: 0)
                        break
                    }
                    
                    self.player1rollButton.isEnabled = true
                    self.player1score = 0
                    self.player1scoreLabel.text = String(self.player1score)
                    self.player1hasGone = false
                    print("roll again")
                    break
                }
                    
                else if (self.dice1.image! == self.dice2.image! && self.dice2.image! == self.dice3.image!)
                {
                    self.player1Triple = true
                    print("hereTriple2")
                    //checkWhoWon()
                    self.dicePlayer1MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 0, playerScore: nil)
                    break
                    
                }
                    
                else if (self.dice1.image! == self.dice2.image!)
                {
                    self.dicePlayer1MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 2, playerScore: nil)
                    break
                }
                    
                else if (self.dice1.image! == self.dice3.image!)
                {
                    self.dicePlayer1MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 1, playerScore: nil)
                    break
                    
                }
                    
                else if (self.dice2.image! == self.dice3.image!)
                {
                    self.dicePlayer1MatchHelper(sameThreeNumArr: self.threeNumArr, thirdDiceNum: 0, playerScore: nil)
                    break
                    
                }
                
            }
            print("Player 1 has went ")
            
            }
            
            }
    }
    
    func dicePlayer1MatchHelper(sameThreeNumArr: [Int], thirdDiceNum: Int?, playerScore: Int? = nil)
    {
        if let diceScore = thirdDiceNum
        {
            player1score = Int(sameThreeNumArr[diceScore] + 1)
        }
        else
        {
            player1score = playerScore!
        }
        amtOfPlayersLeft = amtOfPlayersLeft - 1
        player1scoreLabel.text = String(player1score)
        player2scoreLabel.text = "0"
        player1diceResult.text = "\(sameThreeNumArr[0] + 1)-\(sameThreeNumArr[1] + 1)-\(sameThreeNumArr[2] + 1)"
        player1rollButton.isEnabled = false
        player1rollButton.isHidden = true
        player2rollButton.isEnabled = true
        player2rollButton.isHidden = false
        player2hasGone = false
        player1hasGone = true
        if self.player2active == true
        {
            self.player2rollButton.isEnabled = true
            self.player2rollButton.isHidden = false
        }
        
        if self.player2active == false && self.player3active == true
        {
            self.player3rollButton.isHidden = false
            self.player3rollButton.isEnabled = true
        }
    }
    
    func dicePlayer2MatchHelper(sameThreeNumArr: [Int], thirdDiceNum: Int? = nil, playerScore: Int? = nil)
    {
        if let diceScore = thirdDiceNum
        {
            player2score = Int(sameThreeNumArr[diceScore] + 1)
        }
        else
        {
            player2score = playerScore!
        }
        amtOfPlayersLeft = self.amtOfPlayersLeft - 1
        player2scoreLabel.text = String(player2score)
        player2diceResult.text = "\(sameThreeNumArr[0] + 1)-\(sameThreeNumArr[1] + 1)-\(sameThreeNumArr[2] + 1)"
        player2rollButton.isEnabled = false
        player2rollButton.isHidden = true
        
        if player3active == true
        {
            self.player3rollButton.isEnabled = true
            self.player3rollButton.isHidden = false
        }
        
        player2hasGone = true
        checkWhoWon()
        
    }
    
    func dicePlayer3MatchHelper(sameThreeNumArr: [Int], thirdDiceNum: Int? = nil, playerScore: Int? = nil)
    {
        if let diceScore = thirdDiceNum
        {
            player3score = Int(sameThreeNumArr[diceScore] + 1)
        }
        else
        {
            player3score = playerScore!
        }
        amtOfPlayersLeft = self.amtOfPlayersLeft - 1
        player3scoreLabel.text = String(player3score)
        player3diceResult.text = "\(threeNumArr[0] + 1)-\(threeNumArr[1] + 1)-\(threeNumArr[2] + 1)"
        player3rollButton.isEnabled = false
        player3rollButton.isHidden = true
        player3hasGone = true
        checkWhoWon()
        
    }
    
    
    func winningImage(name: String)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.4)
        {
            self.dice1.isHidden = true
            self.dice2.isHidden = true
            self.dice3.isHidden = true
            self.resultImage.isHidden = false
            self.resultImage.contentMode = .scaleAspectFill
            
            
            if name == "tie12"
            {
                self.resultImage.image = UIImage(named: "tie")
                self.gameTied12()
            }
            
            if name == "tie13"
            {
                self.resultImage.image = UIImage(named: "tie")
                self.gameTied13()
            }
            
            if name == "tie23"
            {
                self.resultImage.image = UIImage(named: "tie")
                self.gameTied23()
            }
            
            if name == "tie123"
            {
                self.resultImage.image = UIImage(named: "tie")
                self.gameTied()
            }
            
            if name == "player1wins"
            {
                self.resultImage.image = UIImage(named: "player1wins")
                self.audioPlayer4.play()
                self.gameCompleted()
            }
            
            if name == "player2wins"
            {
                self.resultImage.image = UIImage(named: "player2wins")
                self.audioPlayer4.play()
                self.gameCompleted()
            }
            
            if name == "player3wins"
            {
                self.resultImage.image = UIImage(named: "player3wins")
                self.audioPlayer4.play()
                self.gameCompleted()
            }
        }
    }
    
    func resetHelper()
    {
        player1score = 0
        player2score = 0
        player3score = 0
        randomIndexVar1 = 0
        randomIndexVar2 = 0
        randomIndexVar3 = 0
        player1scoreLabel.text = "0"
        player2scoreLabel.text = "0"
        player3scoreLabel.text = "0"
        gameDecided = false
        threeNumArr = [0,0,0]
        dice1.isHidden = false
        dice2.isHidden = false
        dice3.isHidden = false
        resultImage.isHidden = true
    }
    
    
    public func resetEverythingP1nP2()
    {
        resetHelper()
        player1diceResult.text = "0-0-0"
        player2diceResult.text = "0-0-0"
        player1rollButton.isHidden = false
        player1rollButton.isEnabled = true
        player1oneTwoThree = false
        player2oneTwoThree = false
        player1fourFiveSix = false
        player2fourFiveSix = false
        player1Triple = false
        player2Triple = false
        player1active = true
        player1hasGone = false
        player2active = true
        player2hasGone = false
        player3active = false
        
        
    }
    
    public func resetEverythingP1nP3()
    {
        resetHelper()
        player1diceResult.text = "0-0-0"
        player3diceResult.text = "0-0-0"
        player1rollButton.isHidden = false
        player1rollButton.isEnabled = true
        player1oneTwoThree = false
        player3oneTwoThree = false
        player1fourFiveSix = false
        player3fourFiveSix = false
        player1Triple = false
        player3Triple = false
        player1active = true
        player1hasGone = false
        player2active = false
        player3active = true
        player3hasGone = false
        
    }
    
    public func resetEverythingP2nP3()
    {
        resetHelper()
        player2diceResult.text = "0-0-0"
        player3diceResult.text = "0-0-0"
        player2rollButton.isHidden = false
        player2rollButton.isEnabled = true
        player2oneTwoThree = false
        player3oneTwoThree = false
        player2fourFiveSix = false
        player3fourFiveSix = false
        player2Triple = false
        player3Triple = false
        player1active = false
        player2active = true
        player2hasGone = false
        player3active = true
        player3hasGone = false
    }
    
    public func resetEverythingButBetAmt()
    {
        resetHelper()
        player1diceResult.text = "0-0-0"
        player2diceResult.text = "0-0-0"
        player3diceResult.text = "0-0-0"
        player1rollButton.isHidden = false
        player1rollButton.isEnabled = true
        player3oneTwoThree = false
        player2oneTwoThree = false
        player1oneTwoThree = false
        player3fourFiveSix = false
        player2fourFiveSix = false
        player1fourFiveSix = false
        player1Triple = false
        player2Triple = false
        player3Triple = false
        player1hasGone = false
        player2hasGone = false
        player3hasGone = false
        player1active = true
        player2active = true
        player3active = true
    }
    
    
    
    public func resetEverything()
    {
        resetHelper()
        player1rollButton.isEnabled = true
        player1rollButton.isHidden = false 
        player1diceResult.text = "0-0-0"
        player2diceResult.text = "0-0-0"
        player3diceResult.text = "0-0-0"
        player3oneTwoThree = false
        player2oneTwoThree = false
        player1oneTwoThree = false
        player3fourFiveSix = false
        player2fourFiveSix = false
        player1fourFiveSix = false
        player1Triple = false
        player2Triple = false
        player3Triple = false
        player1active = true
        player2active = true
        player3active = true 
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
                checkWhoWonHelper(message: "Three way tie, everyone collects or run it back", winningImageName: "tie", gameDecided: true, amtOfPlayersLeft: 3)
                player1rollButton.isEnabled = true
                player2rollButton.isEnabled = false
                player3rollButton.isEnabled = false
                break
            }
            
            //player1,2 have 456
            else if (player1fourFiveSix == true && player2fourFiveSix == true && player3fourFiveSix == false)
            {
                //Animation for tie here
                checkWhoWonHelper(message: "Two way tie, you have the option to split winnings or run it back", winningImageName: "tie12", gameDecided: true, amtOfPlayersLeft: 2)
                player1rollButton.isEnabled = true
                player2rollButton.isEnabled = false
                break
            }
            
            //player1,3 have 456
            else if (player1fourFiveSix == true && player2fourFiveSix == false && player3fourFiveSix == true)
            {
                //Animation for tie here
                checkWhoWonHelper(message: "Two way tie, you have the option to split winnings or run it back", winningImageName: "tie13", gameDecided: true, amtOfPlayersLeft: 2)
                player1rollButton.isEnabled = true
                player3rollButton.isEnabled = false
                break
            }
            
            //player2,3 have 456
            else if (player1fourFiveSix == false && player2fourFiveSix == true && player3fourFiveSix == true)
            {
                //Animation for tie here
                message = "Two way tie, you have the option to split winnings or run it back"
                print("Two way tie456 player23")
                winningImage(name: "tie23")
                gameDecided = true
                amtOfPlayersLeft = 2
                checkWhoWonHelper(message: "Two way tie, you have the option to split winnings or quit game and choose 2 player option and go for it all", winningImageName: "tie23", gameDecided: true, amtOfPlayersLeft: 2)
                player2rollButton.isEnabled = true
                player3rollButton.isEnabled = false
                break
            }
            
            //player2 has 456
            else if (player1fourFiveSix == false && player2fourFiveSix == true && player3fourFiveSix == false)
            {
                //Animation for win here
                checkWhoWonHelper(message: "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true, amtOfPlayersLeft: 0)
                break
            }
            
            //player1 has 456
            else if (player1fourFiveSix == true && player2fourFiveSix == false && player3fourFiveSix == false)
            {
                //Animation for win here
                checkWhoWonHelper(message: "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player1wins", gameDecided: true, amtOfPlayersLeft: 0)
                break
            }
                
        
            //player3 has 456
            else if (player1fourFiveSix == false && player2fourFiveSix == false && player3fourFiveSix == true)
            {
                //Animation for win here
                checkWhoWonHelper(message: "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)", winningImageName: "player3wins", gameDecided: true, amtOfPlayersLeft: 0)
                break
            }
        
                
            //player1 has triple
            else if (player1Triple == true && player2Triple == false && player3Triple == false)
            {
                //Animation for win here
                checkWhoWonHelper(message: "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player1wins", gameDecided: true, amtOfPlayersLeft: 0)
                break
            }
            
            //player2 has triple
            else if (player1Triple == false && player2Triple == true && player3Triple == false)
            {
                //Animation for win here
                checkWhoWonHelper(message: "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true, amtOfPlayersLeft: 0)
                break
            }
            
            //player3 has triple
            else if (player1Triple == false && player2Triple == false && player3Triple == true)
            {
                //Animation for win here
                checkWhoWonHelper(message: "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)", winningImageName: "player3wins", gameDecided: true, amtOfPlayersLeft: 0)
                break
            }
            
            //all players have triple
            else if(player1Triple == true && player2Triple == true && player3Triple == true)
            {
                if(player1score > player2score && player2score >= player3score || player1score > player3score && player3score >= player2score)
                {
                    //Animation for win here
                    checkWhoWonHelper(message: "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player1wins", gameDecided: true, amtOfPlayersLeft: 0)
                    break
                }
                else if (player2score > player1score && player1score >= player3score || player2score > player3score && player3score >= player1score)
                {
                    //Animation for win here
                    checkWhoWonHelper(message: "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true, amtOfPlayersLeft: 0)
                    break
                }
                
                
                else if (player3score > player1score && player1score >= player2score || player3score > player2score && player2score >= player1score)
                {
                    //Animation for win here
                    checkWhoWonHelper(message: "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)", winningImageName: "player3wins", gameDecided: true, amtOfPlayersLeft: 0)
                    break
                }
            }
            
            //Player12 have triple
            else if(player1Triple == true && player2Triple == true && player3Triple == false)
            {
                if (player1score > player2score)
                {
                    //Animation for win here
                    checkWhoWonHelper(message: "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player1wins", gameDecided: true, amtOfPlayersLeft: 0)
                    break
                }
                
                else if (player2score > player1score)
                {
                    //Animation for win here
                    checkWhoWonHelper(message: "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true, amtOfPlayersLeft: 0)
                    break
                }
                
                else if (player2score == player1score)
                {
                    //Animation for tie here
                    checkWhoWonHelper(message: "Two way tie, you have the option to split winnings or run it back", winningImageName: "tie12", gameDecided: true, amtOfPlayersLeft: 2)
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
                    checkWhoWonHelper(message: "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player1wins", gameDecided: true, amtOfPlayersLeft: 0)
                    break
                }
                    
                else if (player3score > player1score)
                {
                    checkWhoWonHelper(message: "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)", winningImageName: "player3wins", gameDecided: true, amtOfPlayersLeft: 0)
                    break
                }
                    
                else if (player3score == player1score)
                {
                    checkWhoWonHelper(message: "Two way tie, you have the option to split winnings or run it back", winningImageName: "tie13", gameDecided: true, amtOfPlayersLeft: 2)
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
                    checkWhoWonHelper(message: "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true, amtOfPlayersLeft: 0)
                    break
                }
                    
                else if (player3score > player2score)
                {
                    checkWhoWonHelper(message: "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)", winningImageName: "player3wins", gameDecided: true, amtOfPlayersLeft: 0)
                    break
                }
                    
                else if (player2score == player3score)
                {
                    checkWhoWonHelper(message: "Two way tie, you have the option to split winnings or run it back", winningImageName: "tie23", gameDecided: true, amtOfPlayersLeft: 2)
                    player2rollButton.isEnabled = true
                    player3rollButton.isEnabled = false
                    break
                }
                
            }
                
            
            //player 1 wins
            else if(player1score > player2score && player2score >= player3score || player1score > player3score && player3score >= player2score)
            {
                checkWhoWonHelper(message: "player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player1wins", gameDecided: true, amtOfPlayersLeft: 0)
                break
            }
                
            //player 2 wins
            else if(player2score > player1score && player1score >= player3score || player2score > player3score && player3score >= player1score)
            {
                checkWhoWonHelper(message: "player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true, amtOfPlayersLeft: 0)
                break
            }
             
            //player 3 wins
            else if(player3score > player1score && player1score >= player2score || player3score > player2score && player2score >= player1score)
            {
                checkWhoWonHelper(message: "player 3 has won \(betLabel.text!) with a roll of \(player3diceResult.text!)", winningImageName: "player3wins", gameDecided: true, amtOfPlayersLeft: 0)
                break
            }
            
            //player1,2 tie for win
            else if(player1score == player2score && player2score > player3score)
            {
                checkWhoWonHelper(message: "Two way tie, you have the option to split winnings or run it back", winningImageName: "tie12", gameDecided: true, amtOfPlayersLeft: 2)
                player1rollButton.isEnabled = true
                player2rollButton.isEnabled = false
                break
            }
            
            //player2,3 tie for win
            else if(player2score == player3score && player3score > player1score)
            {
                checkWhoWonHelper(message: "Two way tie, you have the option to split winnings or run it back", winningImageName: "tie23", gameDecided: true, amtOfPlayersLeft: 2)
                player2rollButton.isEnabled = true
                player3rollButton.isEnabled = false
                break
            }
            
            //player1,3 tie for win 
            else if(player1score == player3score && player3score > player2score)
            {
                checkWhoWonHelper(message: "Two way tie, you have the option to split winnings or run it back", winningImageName: "tie13", gameDecided: true, amtOfPlayersLeft: 2)
                player1rollButton.isEnabled = true
                player3rollButton.isEnabled = false 
                break
                
            }
            
        }
      
    }
    
    func checkWhoWonHelper(message: String, winningImageName: String, gameDecided: Bool, amtOfPlayersLeft: Int)
    {
        self.message = message
        winningImage(name: winningImageName)
        self.gameDecided = gameDecided
        self.amtOfPlayersLeft = amtOfPlayersLeft
    }
    
   
    func gameCompleted()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.9)
        {
            let alertController = UIAlertController(title: "Game complete", message: self.message, preferredStyle: .alert)
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
    }
    
    //Winner is still being decided
    func gameTied()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.9)
        {
            print("Game is tied")
            let alertController = UIAlertController(title: "Game complete", message: self.message, preferredStyle: .alert)
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
    }
    
    func gameTied12()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.9)
        {
            print("Game is tied")
            let alertController = UIAlertController(title: "Game complete", message: self.message, preferredStyle: .alert)
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
    }
    
    func gameTied13()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.9)
        {
            print("Game is tied")
            let alertController = UIAlertController(title: "Game complete", message: self.message, preferredStyle: .alert)
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
    }
    
    func gameTied23()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.9)
        {
            print("Game is tied")
            let alertController = UIAlertController(title: "Game complete", message: self.message, preferredStyle: .alert)
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
