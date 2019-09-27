//
//  ViewController.swift
//  newNotesApp
//
//  Created by Mikias Kifetew on 2019-09-27.
//  Copyright © 2019 MK_corp. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notesArr = [Entry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //How many cells there should be
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArr.count
    }
    
    
    //What a cell should contain
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteEntry", for: indexPath)
        cell.textLabel?.text = notesArr[indexPath.row].name
        return cell
    }
    
    //When a user selects a table cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //What happens when a user decides to add another note
    @IBAction func noteAdded(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "whenCellPressed", sender: self)
        
    }
    
  
    


}

