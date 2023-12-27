//
//  FlickrEndpoint.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 31/10/22.
//

import Foundation
enum FlickrConstants {
    static let flickrAPIKey = ""
}

enum FlickrEndpoint {
    case search(latitude: Double, longitude: Double)
}

extension FlickrEndpoint: APIRequest {

    var baseURL: String {
        "https://api.flickr.com/services/rest/"
    }

    var method: String {
        switch self {
        case .search:
            return "flickr.photos.search"
        }
    }

    var httpMethod: String {
        switch self {
        case .search:
            return "GET"
        }
    }

    var httpBody: Data? {
        nil
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let lat, let lon):
            return [
                URLQueryItem(name: "api_key", value: FlickrConstants.flickrAPIKey),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
                URLQueryItem(name: "method", value: method),
                URLQueryItem(name: "radius", value: "0.5"),
                URLQueryItem(name: "geo_context", value: "2"),
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)")
            ]
        }
    }


}
