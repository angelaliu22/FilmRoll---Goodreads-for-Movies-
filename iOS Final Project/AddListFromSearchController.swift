//
//  AddListFromSearchController.swift
//  iOS Final Project
//
//  Created by Angela Liu on 12/9/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import UIKit

class AddListFromSearchController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var newListName: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    var lists = [List]()
    var newMovie = Movie()
    
    @IBAction func cancel() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func addToList() {
        var list = List(listName: newListName.text, movies: [newMovie])
        self.lists.append(list)
    }
    
    func movieAddedAlert() {
        let alertController = UIAlertController(title: "Movie Added!", message:
            "\(newMovie.title) has been added to the list \(newListName.text)!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backToSearchFromAdd" {
            addToList()
            (segue.destinationViewController as! SearchViewController).lists = self.lists
            (segue.destinationViewController as! SearchViewController).newMovie = self.newMovie
        }
    }
}