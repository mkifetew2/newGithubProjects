//
//  TwoPlayerIIViewController.swift
//  Cee-lo
//
//  Created by Mikias Kifetew on 2019-04-28.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit
import AVFoundation

class TwoPlayerIIViewController: UIViewController, UITextFieldDelegate {
    
    
    //Necessary audio players for sounds required in game
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var audioPlayer3 = AVAudioPlayer()
    var audioPlayer4 = AVAudioPlayer()

    //On screen outlets
    @IBOutlet weak var dice1Image: UIImageView!
    @IBOutlet weak var dice2Image: UIImageView!
    @IBOutlet weak var dice3Image: UIImageView!
    @IBOutlet weak var resultImage: UIImageView!
    
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
    
    //Necessary arrays for getting images
    var threeNumArr : [Int] = [0,0,0]
    var diceNameArr = ["DICE1B", "DICE2B", "DICE3B", "DICE4B", "DICE5B", "DICE6B"]
    
    
    //Variable to know whether or not player got 4-5-6 in any form
    var player1fourFiveSix = false
    var player2fourFiveSix = false
    
    //Variable to know whether or not player got triple in any form
    var player1Triple = false
    var player2Triple = false
    
    //Variable to know whether or not player got 1-2-3 in any form
    var player1oneTwoThree = false
    var player2oneTwoThree = false
    
    //Varible which holds players scores
    var player1score : Int = 0
    var player2score : Int = 0
    
    //If player has gone or not
    var player1hasGone : Bool = false
    var player2hasGone : Bool = false
    
    //If the game is finished
    var gameDecided : Bool = false
    
    //Variables that help with the randomization of the on dice screen
    var randomIndexVar1 : Int?
    var randomIndexVar2 : Int?
    var randomIndexVar3 : Int?
    
    var minTurns = 0
    
    //Outlets for the on screen roll buttons
    @IBOutlet weak var player1rollButton: UIButton!
    @IBOutlet weak var player2rollButton: UIButton!
    
    
    //Message that will be used in the alert controller
    var message = ""
    
    
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        //Gives the dice images a non-winning combination on-screen to start
        dice1Image.image = UIImage(named: "DICE2B")
        dice2Image.image = UIImage(named: "DICE3B")
        dice3Image.image = UIImage(named: "DICE4B")
        
        //Assign the textField delegate to this class
        betTextField.delegate = self
        
        //Hide the player2rollButton to start
        player2rollButton.isHidden = true
        
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
    
    //Disables rolling so that while the dice on-screen is changing the button can't be pressed
    func disableRolling()
    {
        player1rollButton.isEnabled = false
        player2rollButton.isEnabled = false
    }
    
    //Responsible for changing the images on screen
    func changeImage()
    {
        dice1Image.image = UIImage(named: diceNameArr[Int(arc4random_uniform (UInt32(self.diceNameArr.count)))])
        dice2Image.image = UIImage(named: diceNameArr[Int(arc4random_uniform (UInt32(self.diceNameArr.count)))])
        dice3Image.image = UIImage(named: diceNameArr[Int(arc4random_uniform (UInt32(self.diceNameArr.count)))])
    }
    
    //Helps change the images in delayed segments after the user presses the roll button
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
    
    //Functions to test the functionality of hiearchy of winning
    func testPlayer1Roll()
    {
        randomIndexVar1 = 0
        randomIndexVar2 = 1
        randomIndexVar3 = 2
        threeNumArr[0] = randomIndexVar1!
        threeNumArr[1] = randomIndexVar2!
        threeNumArr[2] = randomIndexVar3!
        UIUpdates(listofNums: threeNumArr)
    }
    
    func testPlayer2Roll()
    {
        randomIndexVar1 = 3
        randomIndexVar2 = 4
        randomIndexVar3 = 5
        threeNumArr[0] = randomIndexVar1!
        threeNumArr[1] = randomIndexVar2!
        threeNumArr[2] = randomIndexVar3!
        UIUpdates(listofNums: threeNumArr)
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
    
    //Takes the parameter given and displays an image on screen
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
       
        
        //Game not decided yet and increment times have rolled
        gameDecided = false
        player1Turns = player1Turns + 1
        
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
            
            
            print("player 1 has gone \(self.player1Turns) times")
            
            //Checking the possible outcomes what the diceRoll has generated
            while (self.player1hasGone == false)
        {
            if (self.dice2Image.image! != self.dice3Image.image! && self.dice1Image.image! != self.dice3Image.image! &&  self.dice1Image.image! != self.dice2Image.image!)
            {
                //Checking if the player got 4-5-6 in any form
                if (self.diceNameArr[self.threeNumArr[0]] == "DICE4B" && self.diceNameArr[self.threeNumArr[1]] == "DICE5B" && self.diceNameArr[self.threeNumArr[2]] == "DICE6B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE4B" && self.diceNameArr[self.threeNumArr[1]] == "DICE6B" && self.diceNameArr[self.threeNumArr[2]] == "DICE5B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE5B" && self.diceNameArr[self.threeNumArr[1]] == "DICE4B" && self.diceNameArr[self.threeNumArr[2]] == "DICE6B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE5B" && self.diceNameArr[self.threeNumArr[1]] == "DICE6B" && self.diceNameArr[self.threeNumArr[2]] == "DICE4B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE6B" && self.diceNameArr[self.threeNumArr[1]] == "DICE4B" && self.diceNameArr[self.threeNumArr[2]] == "DICE5B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE6B" && self.diceNameArr[self.threeNumArr[1]] == "DICE5B" && self.diceNameArr[self.threeNumArr[2]] == "DICE4B")
                    {
                        //Launches the special sound for 4-5-6
                        self.audioPlayer3.play()
                        
                        //Sets the var to true so later will be considered automatic win, score set to 6 on screen
                        //Sets the diceResult text to whatever the roll was
                        //Disables and hides player1Roll button and enables and shows player2Roll button
                        //Player 1 has gone and player 2 hasn't
                        self.player1fourFiveSix = true
                        self.player1score = 6
                        self.player1Score.text = String(self.player1score)
                        self.player2Score.text = "0"
                        self.player1diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                        self.player1rollButton.isEnabled = false
                        self.player1rollButton.isHidden = true
                        self.player2rollButton.isEnabled = true
                        self.player2rollButton.isHidden = false
                        self.player2hasGone = false
                        self.player1hasGone = true
                        print("here456")
                        break
                    
                    }
                //Checking if the player got 1-2-3 in any form
                if (self.diceNameArr[self.threeNumArr[0]] == "DICE1B" && self.diceNameArr[self.threeNumArr[1]] == "DICE2B" && self.diceNameArr[self.threeNumArr[2]] == "DICE3B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE1B" && self.diceNameArr[self.threeNumArr[1]] == "DICE3B" && self.diceNameArr[self.threeNumArr[2]] == "DICE2B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE2B" && self.diceNameArr[self.threeNumArr[1]] == "DICE1B" && self.diceNameArr[self.threeNumArr[2]] == "DICE3B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE2B" && self.diceNameArr[self.threeNumArr[1]] == "DICE3B" && self.diceNameArr[self.threeNumArr[2]] == "DICE1B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE3B" && self.diceNameArr[self.threeNumArr[1]] == "DICE1B" && self.diceNameArr[self.threeNumArr[2]] == "DICE2B" ||
                    self.diceNameArr[self.threeNumArr[0]] == "DICE3B" && self.diceNameArr[self.threeNumArr[1]] == "DICE2B" && self.diceNameArr[self.threeNumArr[2]] == "DICE1B")
                    {
                        //Launches the special sound for 1-2-3
                        self.audioPlayer2.play()
                        
                        //Sets the var to true so later will be considered automatic loss, score set to 0 on screen
                        //Sets the diceResult text to whatever the roll was
                        //Disables and hides player1Roll button and enables and shows player2Roll button
                        //Player 1 has gone and player 2 hasn't
                        self.player1oneTwoThree = true
                        self.player1score = 0
                        self.player1Score.text = String(self.player1score)
                        self.player2Score.text = "0"
                        self.player1diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                        self.player1rollButton.isEnabled = false
                        self.player1rollButton.isHidden = true
                        self.player2rollButton.isEnabled = true
                        self.player2rollButton.isHidden = false
                        self.player2hasGone = false
                        self.player1hasGone = true
                        //reloadInputViews()
                        print("here123")
                        break
                    }
                
                //This would mean they didn't get to score
                //player1Roll button is still enabled
                self.player1rollButton.isEnabled = true
                self.player1score = 0
                self.player1Score.text = String(self.player1score)
                self.player2Score.text = "0"
                self.player2rollButton.isEnabled = false
                self.player1hasGone = false
                print("roll again")
                break
            }
            
            //Checks if player1 got a triple on the roll
            else if (self.dice1Image.image! == self.dice2Image.image! && self.dice2Image.image! == self.dice3Image.image!)
            {
                //Sets the var to true, sets score to whatever the triple was
                //Sets the diceResult text to whatever the roll was
                //Disables and hides player1Roll button and enables and shows player2Roll button
                //Player 1 has gone and player 2 hasn't
                self.player1Triple = true
                self.player1score = Int(self.threeNumArr[0] + 1)
                self.player1Score.text = String(self.player1score)
                self.player2Score.text = "0"
                self.player1diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                self.player1rollButton.isEnabled = false
                self.player1rollButton.isHidden = true
                self.player2rollButton.isEnabled = true
                self.player2rollButton.isHidden = false
                self.player2hasGone = false
                self.player1hasGone = true
                //reloadInputViews()
                print("hereTriple1")
                break
                
            }
            
            //Checks to see if at least two of the three dice match
            else if (self.dice1Image.image! == self.dice2Image.image!)
            {
                //sets score to whatever the third dice that's different from the other two was
                //Sets the diceResult text to whatever the roll was
                //Disables and hides player1Roll button and enables and shows player2Roll button
                //Player 1 has gone and player 2 hasn't
                self.player1score = Int(self.threeNumArr[2] + 1)
                self.player1Score.text = String(self.player1score)
                self.player2Score.text = "0"
                self.player1diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                self.player1rollButton.isEnabled = false
                self.player1rollButton.isHidden = true
                self.player2rollButton.isEnabled = true
                self.player2rollButton.isHidden = false
                self.player2hasGone = false
                self.player1hasGone = true
                //reloadInputViews()
                print("here1")
                break
                
            }
                
            //Checks to see if at least two of the three dice match
            else if (self.dice1Image.image! == self.dice3Image.image!)
            {
                //sets score to whatever the third dice that's different from the other two was
                //Sets the diceResult text to whatever the roll was
                //Disables and hides player1Roll button and enables and shows player2Roll button
                //Player 1 has gone and player 2 hasn't
                self.player1score = Int(self.threeNumArr[1] + 1)
                self.player1Score.text = String(self.player1score)
                self.player2Score.text = "0"
                self.player1diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                self.player1rollButton.isEnabled = false
                self.player1rollButton.isHidden = true
                self.player2rollButton.isEnabled = true
                self.player2rollButton.isHidden = false
                self.player2hasGone = false
                self.player1hasGone = true
                //reloadInputViews()
                print("here2")
                break
                
            }
                
             //Checks to see if at least two of the three dice match
            else if (self.dice2Image.image! == self.dice3Image.image!)
            {
                //sets score to whatever the third dice that's different from the other two was
                //Sets the diceResult text to whatever the roll was
                //Disables and hides player1Roll button and enables and shows player2Roll button
                //Player 1 has gone and player 2 hasn't
                self.player1score = Int(self.threeNumArr[0] + 1)
                self.player1Score.text = String(self.player1score)
                self.player2Score.text = "0"
                self.player1diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                self.player1rollButton.isEnabled = false
                self.player1rollButton.isHidden = true
                self.player2rollButton.isEnabled = true
                self.player2rollButton.isHidden = false
                self.player2hasGone = false
                self.player1hasGone = true
                //reloadInputViews()
                print("here3")
                break
            }
            
            
            
        }
        }
        print("Player 1 has went")
    }
    
    
    @IBAction func player2roll(_ sender: UIButton)
    {
        //The sound of dice rolling
        audioPlayer.play()
        
        //Launches the randomImageFirst method to get the dice rolling animation
        randomImageFirst()
        
        //Delayed part executed after 1.2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2)
        {
            //The dice roll which will determine whether the score for the player
            self.diceRoll()
            self.player2Turns = self.player2Turns + 1
            print("player 2 has gone \(self.player2Turns) times")
            
            //Checking the possible outcomes what the diceRoll has generated
            while(self.player2hasGone == false)
            {
                
               //Checking if the player got 4-5-6 in any form
                if (self.dice2Image.image! != self.dice3Image.image! && self.dice1Image.image! != self.dice3Image.image! &&  self.dice1Image.image! != self.dice2Image.image!)
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
                        
                        //Sets the var to true so later will be considered automatic win, score set to 6 on screen
                        //Sets the diceResult text to whatever the roll was
                        //Disables and hides player2Roll button
                        //Player 2 has gone
                        //Checks who won the game between the players
                        self.player2fourFiveSix = true
                        self.player2score = 6
                        self.player2Score.text = String(self.player2score)
                        self.player2diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                        self.player2rollButton.isEnabled = false
                        self.player2rollButton.isHidden = true
                        self.player2hasGone = true
                        //reloadInputViews()
                        print("here456")
                        self.checkWhoWon()
                        break
                    }
                    
                    //Checking if the player got 1-2-3 in any form
                    if (self.diceNameArr[self.threeNumArr[0]] == "DICE1B" && self.diceNameArr[self.threeNumArr[1]] == "DICE2B" && self.diceNameArr[self.threeNumArr[2]] == "DICE3B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE1B" && self.diceNameArr[self.threeNumArr[1]] == "DICE3B" && self.diceNameArr[self.threeNumArr[2]] == "DICE2B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE2B" && self.diceNameArr[self.threeNumArr[1]] == "DICE1B" && self.diceNameArr[self.threeNumArr[2]] == "DICE3B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE2B" && self.diceNameArr[self.threeNumArr[1]] == "DICE3B" && self.diceNameArr[self.threeNumArr[2]] == "DICE1B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE3B" && self.diceNameArr[self.threeNumArr[1]] == "DICE1B" && self.diceNameArr[self.threeNumArr[2]] == "DICE2B" ||
                        self.diceNameArr[self.threeNumArr[0]] == "DICE3B" && self.diceNameArr[self.threeNumArr[1]] == "DICE2B" && self.diceNameArr[self.threeNumArr[2]] == "DICE1B")
                    {
                        //Launches the special sound for 1-2-3
                        self.audioPlayer2.play()
                        
                        //Sets the var to true so later will be considered automatic loss, score set to 0 on screen
                        //Sets the diceResult text to whatever the roll was
                        //Disables and hides player2Roll button
                        //Both players have gone
                        //Checks to see who won between the players
                        self.player2oneTwoThree = true
                        self.player2score = 0
                        self.player2Score.text = String(self.player2score)
                        self.player2diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                        self.player2rollButton.isEnabled = false
                        self.player2rollButton.isHidden = true
                        self.player2hasGone = true
                        //reloadInputViews()
                        print("here123")
                        self.checkWhoWon()
                        break
                    }
                    
                    //This would mean they didn't get to score
                    //player2Roll button is still enabled
                    self.player2rollButton.isEnabled = true
                    self.player2score = 0
                    self.player2Score.text = String(self.player2score)
                    self.player1rollButton.isEnabled = false
                    self.player2hasGone = false
                    print("roll again")
                    break
                }
                
                //Checks if player2 got a triple on the roll
                else if (self.dice1Image.image! == self.dice2Image.image! && self.dice2Image.image! == self.dice3Image.image!)
                {
                    //Sets the var to true, sets score to whatever the triple was
                    //Sets the diceResult text to whatever the roll was
                    //Disables and hides player2Roll button a
                    //Both players have gone
                    //Checks who won
                    self.player2Triple = true
                    self.player2score = Int(self.threeNumArr[0] + 1)
                    self.player2Score.text = String(self.player2score)
                    self.player2diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                    self.player2rollButton.isEnabled = false
                    self.player2rollButton.isHidden = true
                    self.player1hasGone = false
                    self.player2hasGone = true
                    //reloadInputViews()
                    print("hereTriple2")
                    self.checkWhoWon()
                    break
                    
                }
                
                //Checks to see if at least two of the three dice match
                else if (self.dice1Image.image! == self.dice2Image.image!)
                {
                    //sets score to whatever the third dice that's different from the other two was
                    //Sets the diceResult text to whatever the roll was
                    //Disables and hides player2Roll button
                    //Both players have scored
                    //Checks who won the game
                    self.player2score = Int(self.threeNumArr[2] + 1)
                    self.player2Score.text = String(self.player2score)
                    self.player2diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                    self.player2rollButton.isEnabled = false
                    self.player2rollButton.isHidden = true
                    self.player1hasGone = false
                    self.player2hasGone = true
                    //reloadInputViews()
                    print("here 4")
                    self.checkWhoWon()
                    break
                }
                
                //Checks to see if at least two of the three dice match
                else if (self.dice1Image.image! == self.dice3Image.image!)
                {
                    //sets score to whatever the third dice that's different from the other two was
                    //Sets the diceResult text to whatever the roll was
                    //Disables and hides player2Roll button
                    //Both players have scored
                    //Checks who won the game
                    self.player2score = Int(self.threeNumArr[1] + 1)
                    self.player2Score.text = String(self.player2score)
                    self.player2diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                    self.player2rollButton.isEnabled = false
                    self.player2rollButton.isHidden = true
                    self.player1hasGone = false
                    self.player2hasGone = true
                    //reloadInputViews()
                    print("here5")
                    self.checkWhoWon()
                    break
                }
                   
                //Checks to see if at least two of the three dice match
                else if (self.dice2Image.image! == self.dice3Image.image!)
                {
                    //sets score to whatever the third dice that's different from the other two was
                    //Sets the diceResult text to whatever the roll was
                    //Disables and hides player2Roll button
                    //Both players have scored
                    //Checks who won the game
                    self.player2score = Int(self.threeNumArr[0] + 1)
                    self.player2Score.text = String(self.player2score)
                    self.player2diceResult.text = "\(self.threeNumArr[0] + 1)-\(self.threeNumArr[1] + 1)-\(self.threeNumArr[2] + 1)"
                    self.player2rollButton.isEnabled = false
                    self.player2rollButton.isHidden = true
                    self.player1hasGone = false
                    self.player2hasGone = true
                    //reloadInputViews()
                    print("here6")
                    self.checkWhoWon()
                    break
                }
                
                
            }
            print("Player 2 has went")
        }
        
            
            
    }
    
    //What kind of reset is necessary so if it's tied it will be "EverythingButBetAmt"
    //else it will be "Everything"
    public func reset(whatKind : String)
    {
        if(whatKind == "Everything")
        {
            resetEverythingButBetAmt()
            submitButton.isEnabled = true
            resetButton.isEnabled = true
            betLabel.text = ""
            betTextField.text = ""
            betTextField.isHidden = false
            betTextField.isEnabled = true
        }
        if(whatKind == "EverythingButBetAmt")
        {
            resetEverythingButBetAmt()
        }
    }
    
    //Resets the game except for the bet amount
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
        threeNumArr = [0,0,0]
        player1hasGone = false
        player2hasGone = false
        player1rollButton.isHidden = false
        player1rollButton.isEnabled = true
        dice1Image.isHidden = false
        dice2Image.isHidden = false
        dice3Image.isHidden = false
        resultImage.isHidden = true
    
    }
    
    //Function to help refactor the checkWhoWon function
    func checkWhoWonHelper(message: String, winningImageName: String, gameDecided: Bool)
    {
        self.message = message
        winningImage(name: winningImageName)
        self.gameDecided = gameDecided
    }
    
    //Checks the score to see which player won or if it was a tie
    func checkWhoWon()
    {
        
        while(gameDecided == false)
        {
            if (player1fourFiveSix == true && player2fourFiveSix == false)
            {
                checkWhoWonHelper(message: "Player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player1wins", gameDecided: true)
                break
            }
            
            else if (player1fourFiveSix == false && player2fourFiveSix == true)
            {
                checkWhoWonHelper(message: "Player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true)
                break
            }
           
            else if (player1fourFiveSix == true && player2fourFiveSix == true)
            {
                checkWhoWonHelper(message: "It's a tie", winningImageName: "tie", gameDecided: true)
                break
            }
            
            else if (player1Triple == true && player2Triple == false)
            {
                checkWhoWonHelper(message: "Player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player1wins", gameDecided: true)
                break
            }
            
            else if (player1Triple == false && player2Triple == true)
            {
                checkWhoWonHelper(message: "Player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true)
                break
            }
            
            else if(player1Triple == true && player2Triple == true)
            {
                if(player1score > player2score)
                {
                    checkWhoWonHelper(message: "Player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player2wins", gameDecided: true)
                    break
                }
                else if (player1score < player2score)
                {
                    checkWhoWonHelper(message: "Player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true)
                    break
                }
                else if (player1score == player2score)
                {
                    checkWhoWonHelper(message: "It's a tie", winningImageName: "tie", gameDecided: true)
                    break
                }
            }
            
            else if(player1oneTwoThree == true && player2oneTwoThree == false)
            {
                checkWhoWonHelper(message: "Player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true)
                break
            }
            else if(player1oneTwoThree == false && player2oneTwoThree == true)
            {
                checkWhoWonHelper(message: "Player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player1wins", gameDecided: true)
                break
            }
            
            else if(player1oneTwoThree == true && player2oneTwoThree == true)
            {
                checkWhoWonHelper(message: "Both players got 1-2-3, you can play again by running it back or take your original bet back and quit game", winningImageName: "tie", gameDecided: true)
                break
            }
            
            else if(player1score > player2score)
            {
                checkWhoWonHelper(message: "Player 1 has won \(betLabel.text!) with a roll of \(player1diceResult.text!)", winningImageName: "player1wins", gameDecided: true)
                break
            }
            
            else if(player1score < player2score)
            {
                checkWhoWonHelper(message: "Player 2 has won \(betLabel.text!) with a roll of \(player2diceResult.text!)", winningImageName: "player2wins", gameDecided: true)
                break
            }
            
            else if(player1score == player2score)
            {
                checkWhoWonHelper(message: "Tie game, you can play again by running it back or take your original bet back and quit game", winningImageName: "tie", gameDecided: true)
                break
            }
            
            
        }
       
    }
    
    //Presents the image on-screen to be displayed after the result is determined
    func winningImage(name: String)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.4)
        {
            self.dice1Image.isHidden = true
            self.dice2Image.isHidden = true
            self.dice3Image.isHidden = true
            self.resultImage.isHidden = false
            self.resultImage.contentMode = .scaleAspectFill
            
            if name == "tie"
            {
                self.resultImage.image = UIImage(named: "tie")
                self.gameTied()
            }
            
            if name == "player1wins"
            {
                self.resultImage.image = UIImage(named: "player1wins")
                self.audioPlayer4.play()
                self.gameOver()
            }
            
            if name == "player2wins"
            {
                self.resultImage.image = UIImage(named: "player2wins")
                self.audioPlayer4.play()
                self.gameOver()
            }
        }
    }

    
    
    //Winner has been decided
    func gameOver()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.9)
        {
            print("Game is over")
                let alertController = UIAlertController(title: "Game complete", message: self.message, preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Run it back?", style: .default) { (action:UIAlertAction) in
                self.reset(whatKind: "Everything")
                self.performSegue(withIdentifier: "runItBack", sender: self)
                print("You've run it back");
            }
            let action2 = UIAlertAction(title: "Quit game", style: .default)
            { (action: UIAlertAction) in
                self.reset(whatKind: "Everything")
                self.performSegue(withIdentifier: "backToLaunch", sender: self)
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
                self.reset(whatKind: "Everything")
                self.performSegue(withIdentifier: "backToLaunch", sender: self)
                print("quit game")
            }
            alertController.addAction(action1)
            alertController.addAction(action2)
            self.present(alertController, animated: true, completion: nil)
        }
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


    
    

