//
//  ContentsViewController.swift
//  newNotesApp
//
//  Created by Mikias Kifetew on 2019-09-27.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit
import CoreData

class ContentsViewController: UIViewController {

    var name : String = ""
    var contents : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNote(_ sender: UIButton) {
        
    }
    
}
