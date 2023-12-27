//
//  ImageRepository.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 1/11/22.
//

import Foundation

protocol ImageRepositoryProtocol {
    func retrieveImages() -> [FlickrImage]
    func storeImage(image: FlickrImage)
}

struct ImageRepository: ImageRepositoryProtocol {

    func retrieveImages() -> [FlickrImage] {
        return fetchStoredImages().sorted(by: { $0.timestamp > $1.timestamp })
    }

    func storeImage(image: FlickrImage) {
        var images = fetchStoredImages()
        images.append(image)
        if let imagesData = try? JSONEncoder().encode(images) {
            UserDefaults.standard.set(imagesData, forKey: "images")
        }
    }


    private func fetchStoredImages() -> [FlickrImage] {
        guard let imagesData = UserDefaults.standard.data(forKey: "images") else {
            return []
        }
        let images = (try? JSONDecoder().decode([FlickrImage].self, from: imagesData)) ?? []
        return images
    }

}
