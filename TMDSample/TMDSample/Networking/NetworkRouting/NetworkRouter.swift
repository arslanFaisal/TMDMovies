//
//  NetworkRouter.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

typealias NetworkCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class{
    
    associatedtype EndPoint: EndPointType
    
    func request(endPoint: EndPoint, completion: @escaping NetworkCompletion)
    func cancel()
}
