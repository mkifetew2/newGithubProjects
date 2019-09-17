//
//  GameplayViewController.swift
//  mathlete
//
//  Created by Mikias Kifetew on 2019-09-15.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit


class GameplayViewController: UIViewController {

    //Necessary on-screen outlets
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    //Two numbers that are randomly generated for the game
    var num1 : Int = 0
    var num2 : Int = 0
    
    //Variables for the score on screen
    var amtOfRightAnswers : Int = 0
    var amtOfQuestions : Int = 0
    
    //Array to hold the buttons
    var buttonArr = [UIButton]()
    
    //Timer variable and how much time the game is
    var timer : Timer?
    var timeLeft = 10
    
    var correctTag : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //Adding the buttons to the array
       buttonArr.append(topLeftButton)
       buttonArr.append(bottomLeftButton)
       buttonArr.append(topRightButton)
       buttonArr.append(bottomRightButton)
       
       startTimer()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gameStarts()
    }
    
    func startTimer()
    {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    func stopTimer()
    {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
        topLeftButton.isEnabled = false
        topRightButton.isEnabled = false
        bottomLeftButton.isEnabled = false
        bottomRightButton.isEnabled = false
        let alertController = UIAlertController(title: "Game is finished", message: "You finished with \(amtOfRightAnswers) out of \(amtOfQuestions) which is \(Float((amtOfRightAnswers/amtOfQuestions) * 100)) percent", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action) in
            self.performSegue(withIdentifier: "okPressed", sender: self)
        }
        
        alertController.addAction(action1)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func onTimerFires()
    {

        timeLeft -= 1
        timeLabel.text = ":\(timeLeft)"
        if(timeLeft > 0)
        {
            timeLabel.text = ":\(timeLeft)"
        }
        else
        {
            stopTimer()
        }
        
        
    }
    
    func gameStarts()
    {

        num1 = Int(arc4random_uniform(50))
        num2 = Int(arc4random_uniform(50))
        let randNum = Int(arc4random_uniform(4))
        let correctAnswer = num1 + num2
        questionLabel.text = "\(num1) + \(num2)"
        buttonArr[randNum].setTitle("\(correctAnswer)", for: .normal)
        for index in 0..<4 where index != randNum
        {
            buttonArr[index].setTitle("\(Int(arc4random_uniform(100)))", for: .normal)
        }
        scoreLabel.text = "\(amtOfRightAnswers)/\(amtOfQuestions)"
        correctTag = buttonArr[randNum].tag
        print(randNum)
        
        
    }
  
    @IBAction func buttonPressed(sender: UIButton)
    {
        let tag = sender.tag
        switch tag
        {
            case 0:
            if tag == correctTag
            {
                amtOfRightAnswers = amtOfRightAnswers + 1
            }
                amtOfQuestions = amtOfQuestions + 1
                gameStarts()
            
            case 1:
            if tag == correctTag
            {
                amtOfRightAnswers = amtOfRightAnswers + 1
            }
                amtOfQuestions = amtOfQuestions + 1
                gameStarts()
            
            case 2:
            if tag == correctTag
            {
                amtOfRightAnswers = amtOfRightAnswers + 1
            }
                amtOfQuestions = amtOfQuestions + 1
                gameStarts()
            
            case 3:
            if tag == correctTag
            {
                amtOfRightAnswers = amtOfRightAnswers + 1
            }
                amtOfQuestions = amtOfQuestions + 1
                gameStarts()
            
            default:
            print("never here")
        }
    }
    

}
