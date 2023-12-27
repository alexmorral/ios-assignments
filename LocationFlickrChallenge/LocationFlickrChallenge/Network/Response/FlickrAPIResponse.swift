//
//  FlickrAPIResponse.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 31/10/22.
//

import Foundation

struct FlickrAPIResponse: Codable {
    var photos: FlickrAPIResponseData
}

struct FlickrAPIResponseData: Codable {
    var page: Int
    var pages: Int
    var perpage: Int
    var total: Int
    var photo: [FlickrAPIPhoto]
}

struct FlickrAPIPhoto: Codable {
    var id: String
    var secret: String
    var server: String
    var title: String
}
