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
    var movies: [Movie]
    
    override init() {
        self.listName = "test"
        self.movies = []
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.listName = "test"
        self.movies = []
//        self.movies = (aDecoder.decodeObjectForKey(listName) as? [Movie])!
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(movies, forKey: listName)
    }
}
