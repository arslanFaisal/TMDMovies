//
//  TrendingMoviesService.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

typealias MovieCompletionBlock = (_ movieResponse: MovieApiResponse?,_ error: String?)-> ()

struct TrendingMoviesService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}
extension TrendingMoviesService {
    func fetchTrendingMovies(page: Int, genre: Int?, completion: @escaping MovieCompletionBlock) {
        networkHandler.fetchData(TMDApi.trending(page: page, genre: genre), completion: {(data, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                let apiResponse = try jsonDecoder.decode(MovieApiResponse.self, from: data)
                completion(apiResponse, nil)
            } catch {
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        })
    }
}

