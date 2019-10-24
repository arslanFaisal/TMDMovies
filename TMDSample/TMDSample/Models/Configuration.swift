//
//  Configuration.swift
//  TMDSample
//
//  Created by Arslan Faisal on 23/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
struct configurationApiResponse: Codable {
    let changeKeys: [String]?
    let images: configuration?
}

struct configuration: Codable {
    let baseUrl         : String?
    let secureBaseUrl   : String?
    let backdropSizes   : [String]?
    let logoSizes       : [String]?
    let posterSizes     : [String]?
    let profileSizes    : [String]?
    let stillSizes      : [String]?
}
