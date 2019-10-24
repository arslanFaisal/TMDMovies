//
//  Utilities.swift
//  TMDSample
//
//  Created by Arslan Faisal on 24/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
extension Date {
    
    func formatedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        return dateFormatter.string(from: self)
    }
    
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
}
