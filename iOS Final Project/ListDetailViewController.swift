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
    
    var list = List()

    struct TableViewCellIdentifiers {
        static let listMovieCell = "ListMovieCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 80
        
        var cellNib = UINib(nibName: TableViewCellIdentifiers.listMovieCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.listMovieCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.loadingCell, bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.loadingCell)
        
//        title = NSLocalizedString("Search", comment: "Split-view master button")
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
    
//    @IBAction func segmentChanged(sender: UISegmentedControl) {
//        performSearch()
//    }
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: NSLocalizedString("Whoops...", comment: "Error alert: title"),
            message: NSLocalizedString("There was an error reading from the iTunes Store. Please try again.", comment: "Error alert: message"),
            preferredStyle: .Alert)
        
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: "Error alert: cancel button"), style: .Default, handler: nil)
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "ShowDetail" {
//            switch search.state {
//            case .Results(let list):
//                let detailViewController = segue.destinationViewController as! DetailViewController
//                let indexPath = sender as! NSIndexPath
//                let searchResult = list[indexPath.row]
//                detailViewController.searchResult = searchResult
//                detailViewController.isPopUp = true
//            default:
//                break
//            }
//        }
//    }
    
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
//            switch newCollection.verticalSizeClass {
//            case .Compact:
//                showLandscapeViewWithCoordinator(coordinator)
//            case .Regular, .Unspecified:
//                hideLandscapeViewWithCoordinator(coordinator)
//            }
//        }
    }
    
//    func showLandscapeViewWithCoordinator(coordinator: UIViewControllerTransitionCoordinator) {
//        precondition(landscapeViewController == nil)
//        
//        landscapeViewController = storyboard!.instantiateViewControllerWithIdentifier("LandscapeViewController") as? LandscapeViewController
//        if let controller = landscapeViewController {
//            controller.search = search
//            
//            controller.view.frame = view.bounds
//            controller.view.alpha = 0
//            
//            view.addSubview(controller.view)
//            addChildViewController(controller)
//            
//            coordinator.animateAlongsideTransition({ _ in
//                controller.view.alpha = 1
//                self.searchBar.resignFirstResponder()
//                
//                if self.presentedViewController != nil {
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                }
//                },
//                completion: { _ in
//                    controller.didMoveToParentViewController(self)
//            })
//        }
//    }
    
//    func hideLandscapeViewWithCoordinator(coordinator: UIViewControllerTransitionCoordinator) {
//        if let controller = landscapeViewController {
//            controller.willMoveToParentViewController(nil)
//            
//            coordinator.animateAlongsideTransition({ _ in
//                controller.view.alpha = 0
//                
//                if self.presentedViewController != nil {
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                }
//                }, completion: { _ in
//                    controller.view.removeFromSuperview()
//                    controller.removeFromParentViewController()
//                    self.landscapeViewController = nil
//            })
//        }
//    }
}

//extension ListDetailViewController: UISearchBarDelegate {
//    func performSearch() {
//        if let category = Search.Category(rawValue: segmentedControl.selectedSegmentIndex) {
//            search.performSearchForText(searchBar.text, category: category, completion: {
//                success in
//                
//                if let controller = self.landscapeViewController {
//                    controller.searchResultsReceived()
//                }
//                
//                if !success {
//                    self.showNetworkError()
//                }
//                
//                self.tableView.reloadData()
//            })
//            
//            tableView.reloadData()
//            searchBar.resignFirstResponder()
//        }
//    }
//    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        performSearch()
//    }
//    
//    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
//        return .TopAttached
//    }
//}

extension ListDetailViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("MOVIE COUNT = " + String(list.movies.count))
        return list.movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifiers.listMovieCell, forIndexPath: indexPath) as! ListMovieCell

        
        let movieResult = list.movies[indexPath.row]
//        let movieResult = result
        cell.configureForMovieResult(movieResult)
        println("MOVIE DETAIL SHOULD BE: " + movieResult.title!);
        
        return cell
    }
}

//extension ListDetailViewController: UITableViewDelegate {
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if view.window!.rootViewController!.traitCollection.horizontalSizeClass == .Compact {
//            tableView.deselectRowAtIndexPath(indexPath, animated: true)
//            performSegueWithIdentifier("ShowDetail", sender: indexPath)
//        } else {
//            switch search.state {
//            case .Results(let list):
//                splitViewDetail?.searchResult = list[indexPath.row]
//            default:
//                break
//            }
//            
//            if splitViewController!.displayMode != .AllVisible {
//                hideMasterPane()
//            }
//        }
//    }
//    
//    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        switch search.state {
//        case .NotSearchedYet, .Loading, .NoResults:
//            return nil
//        case .Results:
//            return indexPath
//        }
//    }
//
//}

