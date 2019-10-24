//
//  Genere.swift
//  TMDSample
//
//  Created by Arslan Faisal on 23/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

struct GenreApiResponse: Codable {
    let genres: [Genre]?
}

struct Genre: Codable {
    let id      : Int?
    let name    : String?
}
