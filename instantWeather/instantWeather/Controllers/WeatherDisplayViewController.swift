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

class WeatherDisplayViewController: UIViewController {

    var cityName : String? = ""
    var weatherDescription : String? = ""
    var cityTemp : Int? = 0
    @IBOutlet weak var weatherDisplay: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBAction func switchPage(_ sender: UIButton)
    {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
