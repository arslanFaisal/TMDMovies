//
//  NetworkHandler.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    
    case staging
    case production
    case development
}

enum NetworkResponse: String {
    
    case success
    case authenticationError    = "Authentication Error"
    case badRequest             = "Bad Request"
    case failed                 = "Network request Failed"
    case noData                 = "No Data Found"
    case unableToDecode         = "Decoding Error"
}

typealias NetworkCompletionBlock = (_ data: Data?,_ error: String?)-> ()

struct NetworkHandler {
    
    static let tmdAPIKey = "51d135946e5a9ee45db3446e8bbe281a"
    static let environment: NetworkEnvironment = .production
    private var router = Router<TMDApi>()
    
}
extension NetworkHandler {

    private func parseHTTPResponse(_ urlResponse:HTTPURLResponse) -> NetworkResponse {
        switch urlResponse.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .authenticationError
        case 501...600:
            return .badRequest
        default:
            return .failed
        }
    }
    func fetchData<EndPoint>(_ endPoint: EndPoint, completion: @escaping NetworkCompletionBlock) where EndPoint:EndPointType{
        
        guard NetworkReachability.shared.isConnected else {
            completion(nil,"No Internet Connectivity.")
            return
        }
        router.request(endPoint: endPoint as! TMDApi) {(data, response, error) in
            self.parseURLRequestData(data: data, response: response, error: error) { (data, error) in
                completion(data, error)
            }
        }
    }
    func parseURLRequestData(data: Data?, response: URLResponse?, error: Error?, completion: @escaping NetworkCompletionBlock) {
        
        if let _ = error {
            completion(nil, "No Internet Connectivity.")
            return
        }
        
        guard let httpURLResponse = response as? HTTPURLResponse else {
            completion(nil, "Network request failed.")
            return
        }
        
        let networkResponse = parseHTTPResponse(httpURLResponse)
        switch networkResponse {
        case .success:
            guard let data = data else {
                completion(nil, NetworkResponse.noData.rawValue)
                return
            }
            completion(data, nil)
        default:
            completion(nil, networkResponse.rawValue)
        }
    }
}
