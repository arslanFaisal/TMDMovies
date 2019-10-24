//
//  HTTPParameterEncoding.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

typealias HTTPParameters = [String:Any]

enum EncodingError: String,Error {
    
    case encodingFailed     = "HTTP parameters are nil"
    case encodeURLMissing   = "url to encode is nil"
}
protocol HTTPParameterEncoder {
    
    static  func encode(urlRequest: inout URLRequest, httpParameters: HTTPParameters) throws
}
