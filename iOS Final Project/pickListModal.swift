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
    let listsManager = ListsManager()
    
    override func viewDidLoad() {
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        let newRowIndex = lists.count
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
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
        cell.detailTextLabel!.text = list.listDescription
        
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
                if let myMovies = lists[indexPath.row].movies {
                    let countMovies = myMovies.count
                    println("MOVIE COUNT: \(countMovies)")
                    
                    //TO DO WHEN DUPLICATE ISSUE IS FIXED: Do not allow duplicate movies lol 
                    
                    lists[indexPath.row].movies?.append(newMovie)
                    listsManager.saveLists()
                    listsManager.loadLists()
                    
                    println("NEW MOVIE ADDED IS: \(newMovie.title)")
                    (segue.destinationViewController as! SearchViewController).lists = self.lists
                    (segue.destinationViewController as! SearchViewController).newMovie = self.newMovie
                    println("LIST COUNT IS: \(lists[indexPath.row].movies?.count)")
                    for (var i = 0; i < lists[0].movies!.count; i++) {
                        println("IN PICK LIST THE MOVIES ARE: \(lists[0].movies![i].title)")
                    }
                }
                // lists[indexPath.row].movies?.append(newMovie)
                
            }
            navigationController?.popViewControllerAnimated(true)
        }
    }
}
