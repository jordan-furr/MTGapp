//
//  CardError.swift
//  MTG
//
//  Created by Jordan Furr on 3/12/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    case thrown(Error)
    case invalidURL
    case noData
    case badData
    
    var errorDescription: String? {
        switch self {
        case .thrown(let error):
            return error.localizedDescription
        case .invalidURL:
            return "unable to reach server"
        case .noData:
            return "server responded with no data"
        case .badData:
            return "server responded with bad data"
        }
    }
}
