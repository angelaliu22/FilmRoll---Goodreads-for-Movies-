//
//  ListsTableController.swift
//  iOS Final Project
//
//  Created by Angela Liu on 12/3/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import UIKit

class ListsTableController: UITableViewController, AddListControllerDelegate {
        
    var lists = [List]()
    
    func addListControllerDidCancel(controller: AddListController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addListController(controller: AddListController, didFinishAddingList list: List) {
    
    
        let newRowIndex = lists.count
        println("")
        println("ROWS INDEX IS : " + String(lists.count))
        println("")

        lists.append(list)
        println("")
        println("ROWS INDEX IS NOW: " + String(lists.count))
        println("")
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func awakeFromNib() {
        println("BEFORE ARE: \(self.lists.count) LISTS")
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        println("ARE THERE ARE LISTS?!?!?!?!?!?!")
        println("THERE ARE: \(self.lists.count) LISTS")
        updateList()
        
    }
    
    func updateList() {
        if !lists.isEmpty {
            tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addList" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddListController
            controller.delegate = self

        }
        else if segue.identifier == "showListDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
//                for list in lists {
//                    if list.listName == lists[indexPath.row] {
//                        println("DID WE FIND ONE??")
                        (segue.destinationViewController as! ListDetailViewController).list = lists[indexPath.row]
//                    }
//                }
            }
        } else if segue.identifier == "searchForMovie" {
            (segue.destinationViewController as! SearchViewController).lists = lists
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        println("HOW ABOUT THIS LIST COUNT: \(lists.count)")
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
}

