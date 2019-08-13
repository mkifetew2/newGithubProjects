//
//  ViewController.swift
//  BitcoinII
//
//  Created by Mikias Kifetew on 2019-05-31.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySigns = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""
    var rowNum = 0
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    
    //Determine how many columns we want in our picker at once
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 
    }
    
    //Determine how many columns we want total in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    //The content which will be displayed on the picker columns, which is the array contents from above
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    //What to do when a row is chosen upon in the scroll view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        rowNum = row
        getPriceData(url: finalURL)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Networking
    func getPriceData(url: String)
    {
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess
                {
                    print("Success! Got the price data")
                    let priceJSON : JSON = JSON(response.result.value)
                    self.updatePriceData(json: priceJSON)
                } else {
                    print("Error: \(response.result.error)")
                    self.priceLabel.text = "Connection Issues"
                }
        }
    }
    
    
    //MARK: - JSON Parsing
    func updatePriceData(json: JSON)
    {
        if let tempPrice = json["bid"].double
        {
            priceLabel.text = "\(currencySigns[rowNum])\(tempPrice)"
        }
        
        else
        {
            priceLabel.text = "Price data not avaliable"
        }
    }


}

