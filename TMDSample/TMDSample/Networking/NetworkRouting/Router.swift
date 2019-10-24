//
//  Router.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType> {
    
    private var urlTask: URLSessionTask?
    
    private func configureRequest(from endPoint: EndPoint) throws -> URLRequest {
        let baseURL = endPoint.baseURL
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(endPoint.path), cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10.0)
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        do {
            switch endPoint.task {
            case .request(let urlParams):
                try configureHTTPParameters(urlRequest: &urlRequest, urlParams: urlParams)
            }
            return urlRequest
        } catch  {
            throw error
        }
    }
    private func configureHTTPParameters(urlRequest: inout URLRequest,urlParams: HTTPParameters?) throws {
        do {
            
            if let params = urlParams {
                try HTTPURLParameterEncoder.encode(urlRequest: &urlRequest, httpParameters: params)
            }
        } catch {
            throw error
        }
    }
}

extension Router: NetworkRouter {
    
    func request(endPoint: EndPoint, completion: @escaping NetworkCompletion) {
        do {
            let urlRquest = try configureRequest(from: endPoint)
            urlTask = URLSession.shared.dataTask(with: urlRquest, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil,nil,error)
        }
        urlTask?.resume()
    }
    
    func cancel() {
        urlTask?.cancel()
    }
}
