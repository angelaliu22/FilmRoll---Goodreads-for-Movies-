//
//  Movie.swift
//  iOS Final Project
//
//  Created by Angela Liu on 12/3/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import Foundation

class Movie {
    
    var title: String?
    var director: String?
    var year: String?
    var rating: String?
    var imgURL: NSURL?
    var actors: String?
    var plot: String?
//    var awards: String?
    
//    var rated: String?
//    var released: String?
//    var runtime: String?
//    var genre: String?
//    var writer: String?
//    var language: String?
    
    init ( ) {
            self.title = ""
            self.director = ""
            self.year = ""
            self.rating = ""
            self.actors = ""
            self.plot = ""
    }
    
    required init(coder aDecoder: NSCoder) {
        self.title = (aDecoder.decodeObjectForKey("title") as? String)!
        self.director = (aDecoder.decodeObjectForKey("director") as? String)!
        self.year = (aDecoder.decodeObjectForKey("year") as? String)!
        self.rating = (aDecoder.decodeObjectForKey("rating") as? String)!
        self.actors = (aDecoder.decodeObjectForKey("actors") as? String)!
        self.plot = (aDecoder.decodeObjectForKey("plot") as? String)!
        self.imgURL = (aDecoder.decodeObjectForKey("plot") as? NSURL)!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.director, forKey: "director")
        aCoder.encodeObject(self.year, forKey: "year")
        aCoder.encodeObject(self.rating, forKey: "rating")
        aCoder.encodeObject(self.actors, forKey: "actors")
        aCoder.encodeObject(self.plot, forKey: "plot")
        aCoder.encodeObject(self.imgURL, forKey: "imgURL")
    }
    
}