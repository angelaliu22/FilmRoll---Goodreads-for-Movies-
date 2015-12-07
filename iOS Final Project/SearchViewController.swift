//
//  ViewController.swift
//  iOS Final Project
//
//  Created by Angela Liu on 11/30/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import UIKit

protocol MovieSearchedDelegate: class {
    func rottenTomatoesWebViewController(controller: SearchViewController, movieSearched movie: String)
}

class SearchViewController: UIViewController {
    
    weak var delegate: MovieSearchedDelegate?
    var listmanager = ListsManager()
    var lists = [List]()
    
    
    @IBOutlet weak var movieQuery: UITextField!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TO DO create a list
        var curList: List = List()
        curList.listName = "test"
        curList.movies = []
        
        
        lists.append(curList)
        movieTitleLabel.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchMovie(sender: UIButton) {
        
        var newMovie = Movie()
        var title = self.movieQuery.text
        IMDbAPI.populateMovieResult(title, movie: newMovie)
        
        dispatch_async(dispatch_get_main_queue(),
            {
                sleep(1)
                println("movie title : \(newMovie.title)")
                self.movieTitleLabel.text = newMovie.title
                let data = NSData(contentsOfURL: newMovie.imgURL!)
                self.moviePoster.image = UIImage(data: data!)
                
        })
        
        delegate?.rottenTomatoesWebViewController(self, movieSearched: movieQuery.text)
        
    }

    @IBAction func addMovieToList() {
        println("list count is: " + String(lists.count))
        var newMovie = Movie();
//        newMovie.title = movieQuery.text;
//        //TO DO ACTUALLY GET THIS DATA FROM QUERY
//        newMovie.rating = "5"
//        newMovie.imgURL = "http://www.freedesign4.me/wp-content/gallery/posters/free-movie-film-poster-the_dark_knight_movie_poster.jpg"
        
        var listname = "test";
        listmanager.addNewMovieToList(listname, movie: newMovie)
    }
}