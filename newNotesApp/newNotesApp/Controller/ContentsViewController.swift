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
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteLabel.text = name
        textView.text = contents

    }
    
    //Dismisses the screen 
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Adds the note when button is pressed
    @IBAction func addNote(_ sender: UIButton) {
        performSegue(withIdentifier: "addedNote", sender: self)
    }
    
    //Prepare for when the note is added
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        name = noteTitle.text!
        contents = textView.text!
        let dstVC = segue.destination as! NotesViewController
        let newEntry = Entry(context: context)
        newEntry.name = name
        newEntry.contents = contents
        dstVC.notesArr.append(newEntry)
    }
    
}
