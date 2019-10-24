//
//  Movie.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

struct MovieApiResponse: Codable {
    let page            : Int?
    let totalResults    : Int?
    let totalPages      : Int?
    let movies          : [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults
        case totalPages
        case movies = "results"
    }
}

struct Movie: Codable {
    let id              : Int?
    let posterPath      : String?
    let backdropPath    : String?
    let title           : String?
    let name            : String?
    let originalName    : String?
    let releaseDate     : Date?
    let rating          : Double?
    let overview        : String?
    let genreIds        : [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath
        case backdropPath
        case title
        case name
        case originalName
        case releaseDate
        case overview
        case genreIds
        case rating = "voteAverage"
    }
}
