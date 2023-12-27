//
//  FlickrImage.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 31/10/22.
//

import Foundation
import CoreLocation

struct FlickrImage: Codable, Identifiable {
    var id: String
    var secret: String
    var server: String
    var timestamp: TimeInterval
    var latitude: Double
    var longitude: Double

    // https://live.staticflickr.com/{server-id}/{id}_{secret}_{size-suffix}.jpg
    var url: URL? {
        URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg")
    }
}
