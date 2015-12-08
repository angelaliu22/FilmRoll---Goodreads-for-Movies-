//
//  List.swift
//  iOS Final Project
//
//  Created by Angela Liu on 12/3/15.
//  Copyright (c) 2015 Angela Liu. All rights reserved.
//

import Foundation

class List: NSObject, NSCoding {
    
    var listName: String
    var movies: [Movie]?
    
    init(listName: String, movies: [Movie]) {
        self.listName = listName
        self.movies = movies
    }
    
    required init(coder aDecoder: NSCoder) {
        self.listName = (aDecoder.decodeObjectForKey("listName") as? String)!
        self.movies = (aDecoder.decodeObjectForKey("movies") as? [Movie])!
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(listName, forKey: "listName")
        //TO DO WHY DOES THIS CRASH
//        aCoder.encodeObject(movies, forKey: "movies")
    }
}
