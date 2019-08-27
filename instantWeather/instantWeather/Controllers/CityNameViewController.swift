//
//  CityNameViewController.swift
//  instantWeather
//
//  Created by Mikias Kifetew on 2019-08-19.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class CityNameViewController: UIViewController, UITextFieldDelegate {
    
    var APP_URL = "http://api.openweathermap.org/data/2.5/weather"
    var APP_ID = "993d139627c4a431d89b8b944c0ea92e"

    @IBOutlet weak var cityEntry: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var desc: String?
    var cityTemp: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityEntry.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if cityEntry.text!.isEmptyField
        {
            submitButton.isEnabled = true
        }
        else
        {
            submitButton.isEnabled = false
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //These two functions should make the keyboard appear and disappear
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func weatherButtonPressed(_ sender: UIButton)
    {
        let cityName = String(cityEntry.text!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dstVC = segue.destination as? WeatherDisplayViewController
        {
            dstVC.cityName = cityEntry.text!
        }
    }
    
    
    
    
}

extension StringProtocol where Index == String.Index {
    var isEmptyField: Bool {
        return trimmingCharacters(in: .whitespaces) == ""
    }
}
    

