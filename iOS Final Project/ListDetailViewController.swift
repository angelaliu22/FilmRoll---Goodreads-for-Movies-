//
//  ListDetailViewController.swift
//  iOS Final Project
//
//  Created by Angela Liu on 12/4/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import UIKit

class ListDetailViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    var list = List?()

    struct TableViewCellIdentifiers {
        static let listMovieCell = "ListMovieCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 100
        
        var cellNib = UINib(nibName: TableViewCellIdentifiers.listMovieCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.listMovieCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.loadingCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.loadingCell)
        
        self.title = "\(list!.listName)"
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideMasterPane() {
        UIView.animateWithDuration(0.25, animations: {
            self.splitViewController!.preferredDisplayMode = .PrimaryHidden
            }, completion: { _ in
                self.splitViewController!.preferredDisplayMode = .Automatic
        })
    }
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: NSLocalizedString("Whoops...", comment: "Error alert: title"),
            message: NSLocalizedString("There was an error reading from the iTunes Store. Please try again.", comment: "Error alert: message"),
            preferredStyle: .Alert)
        
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: "Error alert: cancel button"), style: .Default, handler: nil)
        alert.addAction(action)
        alert.view.tintColor = UIColor.blackColor()
        presentViewController(alert, animated: true, completion: nil)
    }

    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        
        let rect = UIScreen.mainScreen().bounds
        if (rect.width == 736 && rect.height == 414) ||   // portrait
            (rect.width == 414 && rect.height == 736) {    // landscape
                if presentedViewController != nil {
                    dismissViewControllerAnimated(true, completion: nil)
                }
        }
//        else if UIDevice.currentDevice().userInterfaceIdiom != .Pad {
    }
    
//    func showLandscapeViewWithCoordinator(coordinator: UIViewControllerTransitionCoordinator)
    
//    func hideLandscapeViewWithCoordinator(coordinator: UIViewControllerTransitionCoordinator)

}

//extension ListDetailViewController: UISearchBarDelegate

extension ListDetailViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let curList = list {
            return list!.movies!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifiers.listMovieCell, forIndexPath: indexPath) as! ListMovieCell
        let movieResult = list!.movies![indexPath.row]
        println("DETAIL VIEW CONTROLLER MOVIE IS: \(movieResult.title)")
        cell.configureForMovieResult(movieResult)
        return cell
    }
}

//extension ListDetailViewController: UITableViewDelegate


