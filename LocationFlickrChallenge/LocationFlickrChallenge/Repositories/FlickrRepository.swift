//
//  FlickrRepository.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 31/10/22.
//

import Foundation
import CoreLocation

protocol FlickrRepositoryProtocol {
    func retrieveImage(
        location: CLLocationCoordinate2D,
        alreadyDownloadedImageIds: [String]
    ) async throws -> FlickrImage
}

struct FlickrRepository: FlickrRepositoryProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func retrieveImage(
        location: CLLocationCoordinate2D,
        alreadyDownloadedImageIds: [String]
    ) async throws -> FlickrImage {
        let apiRequest = FlickrEndpoint.search(
            latitude: location.latitude,
            longitude: location.longitude
        )
        let data = try await apiClient.performRequest(apiRequest: apiRequest)

        let apiResponse = try JSONDecoder().decode(FlickrAPIResponse.self, from: data)
        guard let firstAPIPhoto = apiResponse.photos.photo.first(where: { !alreadyDownloadedImageIds.contains($0.id)}) else {
            throw APIError.noPhotosReceived
        }

        return FlickrImage(
            id: firstAPIPhoto.id,
            secret: firstAPIPhoto.secret,
            server: firstAPIPhoto.server,
            timestamp: Date.now.timeIntervalSince1970,
            latitude: location.latitude,
            longitude: location.longitude
        )
    }
}
