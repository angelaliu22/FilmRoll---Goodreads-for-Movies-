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
    var awards: String?
    
    var rated: String?
    var released: String?
    var runtime: String?
    var genre: String?
    var writer: String?
    var language: String?
    
    init ( ) {
            self.title = ""
            self.director = ""
            self.year = ""
            self.rating = ""
            self.actors = ""
            self.plot = ""
            self.awards = ""
            self.rated = ""
            self.released = ""
            self.runtime = ""
            self.genre = ""
            self.writer = ""
            self.language = ""
    }
    
}



//{"Title":"Up","Year":"2009","Rated":"PG","Released":"29 May 2009","Runtime":"96 min","Genre":"Animation, Adventure, Comedy","Director":"Pete Docter, Bob Peterson","Writer":"Pete Docter (story), Bob Peterson (story), Tom McCarthy (story), Bob Peterson (screenplay), Pete Docter (screenplay)","Actors":"Edward Asner, Christopher Plummer, Jordan Nagai, Bob Peterson","Plot":"Seventy-eight year old Carl Fredricksen travels to Paradise Falls in his home equipped with balloons, inadvertently taking a young stowaway.","Language":"English","Country":"USA","Awards":"Won 2 Oscars. Another 69 wins & 69 nominations.","Poster":"http://ia.media-imdb.com/images/M/MV5BMTk3NDE2NzI4NF5BMl5BanBnXkFtZTgwNzE1MzEyMTE@._V1_SX300.jpg","Metascore":"88","imdbRating":"8.3","imdbVotes":"600,265","imdbID":"tt1049413","Type":"movie","Response":"True"}