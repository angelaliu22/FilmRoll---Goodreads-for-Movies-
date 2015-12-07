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
  @IBOutlet weak var movieInfo: UILabel!
  @IBOutlet weak var moviePoster: UIImageView!
  
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
    movieInfo.text = movie.rating

    if (movie.rating == "") {
      movieInfo.text = NSLocalizedString("None", comment: "No Ratings Yet")
    }
    
    

    moviePoster.image = UIImage(named: "Placeholder")
    let data = NSData(contentsOfURL: movie.imgURL!)
    self.moviePoster.image = UIImage(data: data!)
  }
    
  override func prepareForReuse() {
    super.prepareForReuse()
    
    downloadTask?.cancel()
    downloadTask = nil
    
    movieName.text = nil
    movieInfo.text = nil
    moviePoster.image = nil
  }
}
