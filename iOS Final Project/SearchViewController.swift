//
//  ViewController.swift
//  iOS Final Project
//
//  Created by Angela Liu on 11/30/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var listmanager = ListsManager()
    var lists = [List]()
    var newMovie = Movie()
    
    
    @IBOutlet weak var movieQuery: UITextField!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = "";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchMovie(sender: UIButton) {
        
        var title = self.movieQuery.text
        IMDbAPI.populateMovieResult(title, movie: newMovie)
        
        dispatch_async(dispatch_get_main_queue(),
            {
                sleep(1)
                println("movie title : \(self.newMovie.title)")
                self.movieTitleLabel.text = self.newMovie.title
                let data = NSData(contentsOfURL: self.newMovie.imgURL!)
                self.moviePoster.image = UIImage(data: data!)
        })
    }

    @IBAction func addMovieToList() {
        println("list count is: " + String(lists.count))
        
        var listname = "test";
//        listmanager.addNewMovieToList(listname, movie: self.newMovie)
        
        for list in self.lists {
            if (list.listName == listname) {
                list.movies?.append(self.newMovie)
                println("movie added!")
            }
        }
        
    }
}