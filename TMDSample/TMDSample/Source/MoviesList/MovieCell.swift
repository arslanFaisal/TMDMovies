//
//  MovieCell.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    var networkHandler          = NetworkHandler()
    var viewModel               : MovieCellViewModel?
        
    override func prepareForReuse() {
        super.prepareForReuse()

        movieImageView.image    = nil
        movieTitleLabel.text    = ""
        movieRatingLabel.text   = ""
    }
    
    @IBOutlet weak var movieImageView       : UIImageView!
    @IBOutlet weak var movieTitleLabel      : UILabel!
    @IBOutlet weak var movieRatingLabel     : UILabel!
    @IBOutlet weak var releaseDateLabel     : UILabel!
    
    
    func setupCell(movie: Movie) {
        
        viewModel = MovieCellViewModel(movie)
        viewModel?.ImageFetched = { [weak self] image in
            DispatchQueue.main.async { [weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
                     self?.movieImageView.image = image
                }, completion: nil)
               
            }
        }
        viewModel?.fetchImage()
        movieTitleLabel.text = viewModel?.movieName
        movieRatingLabel.text = viewModel?.movieModel?.rating?.description
        
        
        movieTitleLabel.text = movie.title?.uppercased()
        movieRatingLabel.text = "⭐️ \(movie.rating?.description ?? "")"
        if let releaseDate = movie.releaseDate {
            releaseDateLabel.text = viewModel?.getReleaseDate(date: releaseDate)
        }
    }
}
