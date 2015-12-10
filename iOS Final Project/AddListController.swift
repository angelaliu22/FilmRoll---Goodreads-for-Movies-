//
//  AddListController.swift
//  iOS Final Project
//
//  Created by Angela Liu on 12/3/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import UIKit

protocol AddListControllerDelegate: class {
    func addListControllerDidCancel(controller: AddListController)
    func addListController(controller: AddListController, didFinishAddingList list: List)
}

class AddListController: UITableViewController, UITextFieldDelegate {

    weak var delegate: AddListControllerDelegate?
    
    @IBOutlet weak var newListName: UITextField!
    @IBOutlet weak var newListDefinition: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBAction func cancel() {
        delegate?.addListControllerDidCancel(self)
    }
    
    @IBAction func done() {
        addList()
    }
    
    var lists = [List]()
    
    override func viewDidLoad() {
        newListName.tintColor = UIColor.blackColor()
        self.navigationController!.navigationBar.barTintColor = UIColor.orangeColor();
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        newListName.resignFirstResponder()
        addList()
        return true
    }
    
    func addList() {
        var list = List(listName: newListName.text, listDescription: newListDefinition.text, movies: [])
        if listisDuplicate(list) {
            duplicateListNameAlert()
            newListName.text = ""
        } else if newListName.text == "" {
            nothingEnteredAlert()
        } else {
            delegate?.addListController(self, didFinishAddingList: list)
        }
    }
    
    func listisDuplicate(list: List) -> Bool {
        for curList in lists {
            if list.listName == curList.listName {
                return true
            }
        }
        return false
    }
    func nothingEnteredAlert() {
        let alertController = UIAlertController(title: "Woops!", message: "No listname entered!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default,handler: nil))
        alertController.view.tintColor = UIColor.blackColor()
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func duplicateListNameAlert() {
        let alertController = UIAlertController(title: "List Name Exists!", message: "Looks like you already have a list with this name!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default,handler: nil))
        alertController.view.tintColor = UIColor.blackColor()
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
