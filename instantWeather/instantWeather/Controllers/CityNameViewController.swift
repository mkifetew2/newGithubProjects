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
    var labelText : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityEntry.delegate = self
        // Do any additional setup after loading the view.
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
        var cityName = String(cityEntry.text!)
        let params : [String : String] = ["q" : cityName, "appid" : APP_ID]
        getWeather(url: APP_URL, params: params)
    }
    
    func getWeather(url: String, params: [String: String])
    {
        Alamofire.request(url, method: .get, parameters: params).responseJSON
            {
                response in
                if response.result.isSuccess
                {
                    print("Success")
                    let weatherData : JSON = JSON(response.result.value!)
                    self.weatherUI(json: weatherData)
                }
                else
                {
                    print("Error \(response.result.error)")
                    self.labelText = "Connection Issues"
                    
                }
        }
    }
    
    func weatherUI(json : JSON)
    {
        var temp = json["main"]["temp"]
        print("This is the temperature:  \(temp)")
    }
    
    
    
    

    

}
