//
//  Enums.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import Foundation

enum UserType {
    case single, married
}

enum ApiError: Int, Error {
    case serializationError = 0,
         networkingError,
         noDataReceived
    
    var errorMessage: String {
        switch self {
        case .serializationError:
            return "There was an error with the data."
        case .networkingError:
            return "There was an issue with the connection. Try again later."
        case .noDataReceived:
            return "No data has been received from the server."
        }
    }
}
