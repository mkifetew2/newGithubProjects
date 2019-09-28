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
    var selectedCell : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
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
        selectedCell = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "updateVC", sender: self)
        
        
        
    }
    
    //What happens when a user decides to add another note
    @IBAction func noteAdded(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "whenCellPressed", sender: self)
    }
    
    
    //Preparing for when a cell gets pressed 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "updateVC" else {return}
        let dstVC = segue.destination as! ContentsViewController
        dstVC.name = notesArr[selectedCell].name!
        dstVC.contents = notesArr[selectedCell].contents!
    }
    
    
    //Saving the notes to the context
    func saveNotes()
    {
        do
        {
            try context.save()
        }
        
        catch
        {
            print("Couldn't save notes \(error)")
        }
        tableView.reloadData()
    }
    
    //Loading the notes from context
    func loadNotes()
    {
        let request : NSFetchRequest<Entry> = Entry.fetchRequest()
        
        do
        {
            notesArr = try context.fetch(request)
        }
        catch
        {
            print("Error loading notes \(error)")
        }
        tableView.reloadData()
    }
    
    
    
  
    


}

