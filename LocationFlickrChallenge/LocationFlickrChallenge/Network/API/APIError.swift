//
//  APIError.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 31/10/22.
//

import Foundation

enum APIError: Error {
    case badRequest
    case badURL
    case cannotBuildRequest
    case noPhotosReceived
}
