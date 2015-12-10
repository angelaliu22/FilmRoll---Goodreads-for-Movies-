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
        
        let queryString = query.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let url = NSURL(string: "http://www.omdbapi.com/?t=\(queryString)")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            (NSString(data: data, encoding: NSUTF8StringEncoding))
            self.handleMovieData(movie, data: data)
        }
        
        task.resume()
    }
    
    class func handleMovieData(movie: Movie, data: NSData) {
        var err: NSError?
        let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as! NSDictionary
        
        if (jsonDict["Response"] as? String == "False") {
            movie.title = "Movie not found"
            movie.rating = ""
            movie.year = ""
            movie.plot = ""
            movie.imgURL = nil
            movie.director = ""
            movie.actors = ""

        } else {
            movie.title = jsonDict["Title"] as? String
            movie.rating = jsonDict["imdbRating"] as? String
            movie.year = jsonDict["Year"] as? String
            movie.plot = jsonDict["Plot"] as? String
            let poster = jsonDict["Poster"] as? String
            movie.imgURL = NSURL(string: poster!)
            movie.director = jsonDict["Director"] as? String
            movie.actors = jsonDict["Actors"] as? String
            
        }
    }
}