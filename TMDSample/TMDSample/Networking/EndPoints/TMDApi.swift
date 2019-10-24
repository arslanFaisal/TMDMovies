//
//  TMDApi.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

enum TMDApi {
    case genre
    case configuration
    case trending(page: Int,genre: Int?)
    case image(path: String)
}
extension TMDApi: EndPointType {
    
    private var envBaseURL: String {
        switch self {
        case .image:
            return "https://image.tmdb.org/t/p/w780"
        default:
            switch NetworkHandler.environment {
            case .production:
                return "https://api.themoviedb.org/3/"
            case .staging:
                return "https://staging.themoviedb.org/3/"
            case .development:
                return "https://qa.themoviedb.org/3/"
            }
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: envBaseURL) else {fatalError("Invalid Base URL.")}
        return url
    }
    
    var path: String {
        
        switch self {
        case .trending:
            return "movie/popular"
        case .genre:
            return "genre/movie/list"
        case .configuration:
            return "configuration"
        case .image(let path):
            return path
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .trending(let page,let genre):
            guard let genre = genre else {
                return .request(urlParams: ["page":page,"api_key":NetworkHandler.tmdAPIKey,"language":Locale.current.languageCode ?? "en"])
            }
            return .request(urlParams: ["page":page,"with_genres":genre,"api_key":NetworkHandler.tmdAPIKey,"language":Locale.current.languageCode ?? "en"])
        case .genre,.configuration:
            return .request(urlParams: ["api_key":NetworkHandler.tmdAPIKey])
        case .image:
            return .request(urlParams: nil)
        }
        
    }
}

