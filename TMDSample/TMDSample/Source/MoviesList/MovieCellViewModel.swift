//
//  MovieCellVM.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
import UIKit

class MovieCellViewModel {
    
    var movieModel              : Movie?
    var imageService            : ImageService
    
    var movieName: String {
        guard let movie = movieModel else {return "No Title found."}
        if let title = movie.title {
            return title
        }else if let originalName = movie.originalName {
            return originalName
        }
        else if let name = movie.name {
            return name
        }else {
            return "No Title found."
        }
    }
    //MARK: Closures
    var ImageFetched            : ((_ image:UIImage)->())?
    
    private init(){
        imageService = ImageService(NetworkHandler())
    }
    convenience init(_ movie: Movie) {
        self.init()
        self.movieModel = movie
    }
}
//MARK: View service Methods
extension MovieCellViewModel {
    func getReleaseDate(date: Date) -> String {
        return date.formatedDateString()
    }
    func fetchImage() {
        guard let movModel = movieModel else { return }
        fetchImageForMovie(movie: movModel)
    }
}
//MARK: Network Fetch Methods
extension MovieCellViewModel {
    
    private func fetchImageForMovie(movie: Movie) {
        var path: String?
        path = movie.backdropPath
        if path == nil {
            path = movie.posterPath
        }
        guard let backdropPath = path else { return }
        imageService.fetchImage(backdropPath, completion: { [weak self](image, errorString) in
            if let image = image, let movModel = self?.movieModel, movModel.backdropPath == movie.backdropPath {
                self?.ImageFetched?(image)
            }
        })
    }
}
