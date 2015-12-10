//
//  ListMovieCell.swift
//  StoreSearch
//
//  Code based on: 
//  Created by M.I. Hollemans on 02/10/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class ListMovieCell: UITableViewCell {
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieYear: UILabel!
//    @IBOutlet weak var movieDescription: UILabel!
    
  
  var downloadTask: NSURLSessionDownloadTask?

  override func awakeFromNib() {
    super.awakeFromNib()
    
    let selectedView = UIView(frame: CGRect.zeroRect)
    selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
    selectedBackgroundView = selectedView
  }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  func configureForMovieResult(movie: Movie) {
    movieName.text = movie.title
    
    moviePoster.image = UIImage(named: "Placeholder")
    
    if movie.imgURL != nil {
        let data = NSData(contentsOfURL: movie.imgURL!) 
        self.moviePoster.image = UIImage(data: data!)
    } else {
        self.moviePoster.image = UIImage(named: "movieperson_placeholder-103642")
    }

    if (movie.rating == nil) {
      movieRating.text = NSLocalizedString("No Ratings Yet", comment: "No Ratings Yet")
    } else {
        movieRating.text = "Rating: \(movie.rating!)"
    }
    
    movieYear.text = "Released: \(movie.year!)"
//    movieDescription.text = movie.plot
    
}
    
  override func prepareForReuse() {
    super.prepareForReuse()
    
    downloadTask?.cancel()
    downloadTask = nil
    
    movieName.text = nil
    moviePoster.image = nil
    movieRating.text = nil
    movieYear.text = nil
//    movieDescription.text = nil
  }
}
