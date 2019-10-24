//
//  GenereService.swift
//  TMDSample
//
//  Created by Arslan Faisal on 23/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

typealias GenreCompletionBlock = (_ genre: [Genre]?,_ error: String?)-> ()

struct GenreService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}
extension GenreService {
    func fetchGenre(completion: @escaping GenreCompletionBlock) {
        networkHandler.fetchData(TMDApi.genre, completion: {(data, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try jsonDecoder.decode(GenreApiResponse.self, from: data)
                completion(apiResponse.genres, nil)
            } catch {
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        })
    }
}
