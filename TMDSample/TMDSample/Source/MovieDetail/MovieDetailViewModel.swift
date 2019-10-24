//
//  MovieDetailViewModel.swift
//  TMDSample
//
//  Created by Arslan Faisal on 24/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewModel {
    
    var imageService            : ImageService
    var movie                   : Movie?
    
    //MARK: Closures
    var ImageFetched            : ((_ image:UIImage)->())?
    
    private init() {
        imageService = ImageService(NetworkHandler())
    }
    convenience init(_ movieModel: Movie?){
        self.init()
        movie = movieModel
    }
}
//MARK: View Service Methods
extension MovieDetailViewModel {
    func getReleaseDate(date: Date) -> String {
        date.formatedDateString()
    }
}
//MARK: Image Fetch Methods
extension MovieDetailViewModel {

    func fetchImage() {
        var path: String?
        if UIDevice.current.orientation.isLandscape {
            path = movie?.posterPath
            if path == nil {
                path = movie?.backdropPath
            }
        }else {
            path = movie?.backdropPath
            if path == nil {
                path = movie?.posterPath
            }
        }
        guard let pathStr = path else { return }
        imageService.fetchImage(pathStr, completion: { [weak self](image, errorString) in
            if let image = image {
                self?.ImageFetched?(image)
            }
        })
    }
}
