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
                    print(weatherData)
                    self.weatherUI(json: weatherData)
                }
                    
                else
                {
                    print("Error \(response.result.error!)")
                }
        }
    }
    
    func weatherUI(json : JSON)
    {
        let temp = json["main"]["temp"].int
        let id = json["weather"][0]["id"].int
        cityTemp = temp! - 273
//        print("This is city temp: \(cityTemp!)")
//        print("This is the temperature:  \(temp!)")
//        print("This is the description: \(description!)")
//        print("This is the ID: \(id!)")
        weatherDisplay(id: id!)
        let nextScreen = WeatherDisplayViewController()
        nextScreen.cityName = cityEntry.text!
        
        
    }
    
    
    func weatherDisplay(id: Int)
    {
        switch id
        {
            case 200, 201, 202, 210, 211, 212, 221, 230, 231, 232:
                desc = "thunderstorm"
            case 300, 301, 302, 310, 311, 312, 313, 314, 321:
                desc = "drizzle"
            case 500, 501, 502, 503, 504, 511, 520, 521, 522, 531:
                desc = "rain"
            case 600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622:
                desc = "snow"
            case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
                desc = "atmosphere"
            case 800:
                desc = "clear sky"
            case 801, 802, 803, 804:
                desc = "clouds"
            default:
                desc = "none"
        }
        print(desc!)
        
        
    }
    
    
}
    

