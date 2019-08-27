//
//  WeatherDisplayViewController.swift
//  instantWeather
//
//  Created by Mikias Kifetew on 2019-08-19.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class WeatherDisplayViewController: UIViewController, CLLocationManagerDelegate {

    var cityName : String?
    var weatherDescription : String?
    var cityTemp : Int? = 0
    @IBOutlet weak var weatherDisplay: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    let locationManager = CLLocationManager()
    var APP_URL = "http://api.openweathermap.org/data/2.5/weather"
    var APP_ID = "993d139627c4a431d89b8b944c0ea92e"
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
        let params : [String : String] = ["q" : cityName!, "appid" : APP_ID]
        getWeather(url: APP_URL, params: params)
        print("here")
        
    }
    
    //This function is for when the location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Since the array in the parameters holds a bunch of nearby locations, the last one is the most accurate
        let currentLocation = locations[locations.count - 1]
        if currentLocation.horizontalAccuracy > 0
        {
            locationManager.stopUpdatingLocation()
            print("Longitude = \(currentLocation.coordinate.longitude), Latitude = \(currentLocation.coordinate.longitude)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if let temp = json["main"]["temp"].int
        {
             cityTemp = temp - 273
        }
        
        
        if let id = json["weather"][0]["id"].int
        {
            weatherDisplay2(id: id)
        }
        else
        {
            weatherDisplay2(id: 0)
        }
        
        
    }

    
    func weatherDisplay2(id: Int)
    {
        switch id
        {
        case 200, 201, 202, 210, 211, 212, 221, 230, 231, 232:
            weatherDescription = "thunderstorm"
            weatherDisplay.image = UIImage(named: "thunderstorm")
        case 300, 301, 302, 310, 311, 312, 313, 314, 321:
            weatherDescription = "drizzle"
            weatherDisplay.image = UIImage(named: "drizzle")
        case 500, 501, 502, 503, 504, 511, 520, 521, 522, 531:
            weatherDescription = "rain"
            weatherDisplay.image = UIImage(named: "rainy2")
        case 600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622:
            weatherDescription = "snow"
            weatherDisplay.image = UIImage(named: "snow")
        case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
            weatherDescription = "atmosphere"
            weatherDisplay.image = UIImage(named: "fog")
        case 800:
            weatherDescription = "clear sky"
            weatherDisplay.image = UIImage(named: "sunny")
        case 801, 802, 803, 804:
            weatherDescription = "clouds"
            weatherDisplay.image = UIImage(named: "overcast")
        default:
            weatherDescription = "none"
            weatherDisplay.image = UIImage(named: "unknown")
        }
        
        tempLabel.text = "\(cityTemp!)℃"
        if let displayName = cityName
        {
            cityLabel.text = displayName
        }
        else
        {
            cityLabel.text = "No entry"
        }
        
        
        
    }

}


