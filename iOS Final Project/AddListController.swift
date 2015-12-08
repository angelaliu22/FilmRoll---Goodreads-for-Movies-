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
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBAction func cancel() {
        delegate?.addListControllerDidCancel(self)
    }
    
    @IBAction func done() {
        var list = List(listName: newListName.text, movies: [])
        delegate?.addListController(self, didFinishAddingList: list)
    }
}
