//
//  pickListModal.swift
//  iOS Final Project
//
//  Created by Angela Liu on 12/8/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import UIKit

class pickListModal: UITableViewController {
    
    var lists = [List]()
    var newMovie = Movie()
    var pickedList: String = ""
    
    override func viewDidLoad() {
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        let newRowIndex = lists.count
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let list = lists[indexPath.row] as List
        cell.textLabel!.text = list.listName
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            lists.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "listPicked" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                self.pickedList = lists[indexPath.row].listName
                (segue.destinationViewController as! SearchViewController).pickedList = self.pickedList
                println("PICKED LIST IS: \(pickedList)")
                
            }
            for list in self.lists {
                if (list.listName == pickedList) {
                    list.movies?.append(self.newMovie)
                    println("movie added! \(newMovie.title)")
                    println("WHAT THE LIST MOVIE COUNT SHOULD BE: \(list.movies!.count)")
                }
            }
            (segue.destinationViewController as! SearchViewController).lists = self.lists
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
