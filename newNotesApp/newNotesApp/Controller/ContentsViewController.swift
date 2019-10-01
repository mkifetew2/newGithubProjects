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

    //variables to hold the contents on the screen
    var name : String = ""
    var contents : String = ""
    
    
    //Necessary on screen outlets
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitle.text = name
        textView.text = contents

    }
    

    
    //Adds the note when button is pressed
    @IBAction func addNote(_ sender: UIButton) {
        name = noteTitle.text ?? "No name"
        contents = textView.text ?? "No contents"
        let dstVC = NotesViewController()
        let newEntry = Entry(context: context)
        newEntry.name = name
        newEntry.contents = contents
        dstVC.notesArr.append(newEntry)
        dstVC.saveNotes()
    }
    
    
    
}
