//
//  IMDbAPI.swift
//  iOS Final Project
//
//  Created by Angela Liu on 12/2/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import Foundation

//Fandango API for ticket, showtime, theater location information 
// Rotten Tomatoes API for Reviews 

class IMDbAPI {
    
    class func populateMovieResult(query: String, movie: Movie) {
        
        let url = NSURL(string: "http://www.omdbapi.com/?t=\(query)")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            NSString(data: data, encoding: NSUTF8StringEncoding)
            self.handleMovieData(movie, data: data)
        }
        
        task.resume()
    }
    
    class func handleMovieData(movie: Movie, data: NSData) {
        println("*~*~*~*~*~*~*~*~*~*~*~*~*")
        var err: NSError?
        let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as! NSDictionary
        
        if (jsonDict["Response"] as? String == "False") {
            movie.title = "Movie not found"
        } else {
            movie.title = jsonDict["Title"] as? String
            movie.rating = jsonDict["imdbRating"] as? String
            movie.year = jsonDict["Year"] as? String
            movie.plot = jsonDict["Plot"] as? String
            let poster = jsonDict["Poster"] as? String
            movie.imgURL = NSURL(string: poster!)
            movie.director = jsonDict["Director"] as? String
            movie.actors = jsonDict["Actors"] as? String
            
            //TODO add awards
        }
    }
}