//
//  NetworkReachability.swift
//  TMDSample
//
//  Created by Arslan Faisal on 22/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
import Network

class NetworkReachability {
    
    static let shared = NetworkReachability()
    
    var isConnected = true {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNames.networkReachability), object: NetworkReachability.shared.isConnected)
        }
    }
    
    private init(){
        startCheckingForConnectivity()
    }

    private func startCheckingForConnectivity() {
        let networkMoniter = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        networkMoniter.start(queue: queue)
        networkMoniter.pathUpdateHandler = { path in
            NetworkReachability.shared.isConnected = path.status == .satisfied
        }
    }
}
