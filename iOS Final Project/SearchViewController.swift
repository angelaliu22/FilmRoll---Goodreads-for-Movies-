//
//  ViewController.swift
//  iOS Final Project
//
//  Created by Angela Liu on 11/30/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    var listmanager = ListsManager()
    var lists = [List]()
    var newMovie = Movie()
    
    var pickedList: String = ""
    
    @IBOutlet weak var movieQuery: UITextField!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieActors: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
    @IBOutlet weak var SeeMoreReviewsButton: UIButton!
    @IBOutlet weak var SaveToListButton: UIButton!
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true;
        super.viewDidLoad()
        resetValues()
    }
    
    override func viewDidAppear(animated: Bool) {
        if (newMovie.title != "") {
            updateLabels()
        }
    }
    
    func resetValues() {
        movieTitleLabel.text = "";
        moviePoster.image = nil;
        movieYear.text = "";
        movieDirector.text = "";
        movieActors.text = "";
        movieRating.text = "";
        moviePlot.text = "";
        
        yearLabel.hidden = true;
        directorLabel.hidden = true;
        ratingLabel.hidden = true;
        actorsLabel.hidden = true;
        
        SeeMoreReviewsButton.hidden = true
        SaveToListButton.hidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateLabels() {
        self.movieTitleLabel.text = self.newMovie.title
        if let data = NSData(contentsOfURL: self.newMovie.imgURL!) {
            self.moviePoster.image = UIImage(data: data)
        } else {
            self.moviePoster.image = UIImage(named: "movieperson_placeholder-103642")
        }
        self.movieYear.text = self.newMovie.year
        self.movieDirector.text = self.newMovie.director
        self.movieActors.text = self.newMovie.actors
        self.movieRating.text = self.newMovie.rating
        self.moviePlot.text = self.newMovie.plot
        
        yearLabel.hidden = false;
        directorLabel.hidden = false;
        ratingLabel.hidden = false;
        actorsLabel.hidden = false;
        
        SeeMoreReviewsButton.hidden = false
        SeeMoreReviewsButton.enabled = true
        SaveToListButton.hidden = false
        SaveToListButton.enabled = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "getMoreRatings" {

            (segue.destinationViewController as! RottenTomatoesWebViewController).searchedMovieTitle = movieQuery.text
        } else if segue.identifier == "pickList" {
            if !self.lists.isEmpty {
                (segue.destinationViewController as! pickListModal).lists = self.lists
                (segue.destinationViewController as! pickListModal).newMovie = self.newMovie
            }
            else {
                noListsAlert()
            }
        } else if segue.identifier == "addListFromSearch" {
            (segue.destinationViewController as! AddListFromSearchController).lists = self.lists
            (segue.destinationViewController as! AddListFromSearchController).newMovie = self.newMovie
            
        } else if segue.identifier == "fromSearchToListTable" {
            (segue.destinationViewController as! ListsTableController).lists = self.lists
        }
    }
    
    func noListsAlert() {
        let alertController = UIAlertController(title: "Uh Oh!", message:
            "You have no lists to save to :(", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Add A List!", style: UIAlertActionStyle.Default,handler: { action in self.performSegueWithIdentifier("addListFromSearch", sender: self) }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        movieQuery.resignFirstResponder()
        searchForMovie()
        return true
    }
    
    func searchForMovie() {
        var title = self.movieQuery.text
        IMDbAPI.populateMovieResult(title, movie: newMovie)
        
        dispatch_async(dispatch_get_main_queue(),
            {
                sleep(1)
                println("movie title : \(self.newMovie.title)")
                self.updateLabels()
        })
    }
}