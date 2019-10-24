//
//  MovieDetailViewController.swift
//  TMDSample
//
//  Created by Arslan Faisal on 23/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    var movieDetail             : Movie?
    var viewModel               : MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseViewModel()
        setUpView()
    }
    
    @IBAction func crossButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        viewModel?.fetchImage()
    }
}
//MARK: View setup
extension MovieDetailViewController {
    func setUpView() {
        titleLabel.text = movieDetail?.title?.uppercased()
        ratingLabel.text = "⭐️ \(movieDetail?.rating?.description ?? "")"
        if let releaseDate = movieDetail?.releaseDate {
            releaseDateLabel.text = viewModel?.getReleaseDate(date: releaseDate)
        }
        descriptionLabel.text = movieDetail?.overview
    }
}
//MARK: View Model setup
extension MovieDetailViewController {
    private func initialiseViewModel() {
        viewModel = MovieDetailViewModel(movieDetail)
        
        viewModel?.ImageFetched = { [weak self] image in
            DispatchQueue.main.async {
                self?.movieImageView.image = image
            }
        }
        
        viewModel?.fetchImage()
    }
}
