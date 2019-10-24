//
//  ConfigurationService.swift
//  TMDSample
//
//  Created by Arslan Faisal on 23/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

typealias ConfigurationCompletionBlock = (_ configuration: configuration?,_ error: String?)-> ()

struct ConfigurationService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}
extension ConfigurationService {
    func fetchConfiguration(completion: @escaping ConfigurationCompletionBlock) {
        networkHandler.fetchData(TMDApi.configuration, completion: {(data, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try jsonDecoder.decode(configurationApiResponse.self, from: data)
                completion(apiResponse.images, nil)
            } catch {
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        })
    }
}
