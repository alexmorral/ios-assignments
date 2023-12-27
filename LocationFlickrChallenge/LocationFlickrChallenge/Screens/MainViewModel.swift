//
//  MainViewModel.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 31/10/22.
//

import Foundation
import CoreLocation

class MainViewModel: NSObject, ObservableObject {
    private let flickrRepository: FlickrRepositoryProtocol
    private let imageRepository: ImageRepositoryProtocol
    let locationManager = CLLocationManager()

    enum Constants {
        static let distanceNewPhoto: Double = 100
    }

    enum ViewState {
        case idle
        case error(String)
    }

    enum LocationState {
        case stopped
        case locating
    }

    @Published var images: [FlickrImage] = []
    @Published var viewState = ViewState.idle
    @Published var locationState = LocationState.stopped
    var downloadingImage: Bool = false

    init(
        flickrRepository: FlickrRepositoryProtocol = FlickrRepository(),
        imageReposirory: ImageRepositoryProtocol = ImageRepository()
    ) {
        self.flickrRepository = flickrRepository
        self.imageRepository = imageReposirory
        super.init()
        setupView()
    }

    func setupView() {
        images = imageRepository.retrieveImages()
    }

    func toggleLocationUpdates() {
        viewState = .idle
        switch locationState {
        case .stopped:
            startLocationUpdates()
        case .locating:
            stopLocationUpdates()
        }
    }

    private func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted, .denied:
            viewState = .error("App does not have access to location")
            locationState = .stopped
        default:
            locationManager.startUpdatingLocation()
            locationState = .locating
        }
    }

    private func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
        locationState = .stopped
    }

    private func requestNewFlickrImage(location: CLLocationCoordinate2D) {
        downloadingImage = true
        Task { @MainActor in
            do {
                print("Retrieving new image from Flickr")
                let image = try await flickrRepository.retrieveImage(
                    location:location,
                    alreadyDownloadedImageIds: images.map({ $0.id })
                )
                imageRepository.storeImage(image: image)
                images = imageRepository.retrieveImages()
            } catch {
                print(error.localizedDescription)
            }
            downloadingImage = false
        }
    }
}

extension MainViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .restricted, .denied, .notDetermined:
            viewState = .error("App does not have access to location")
            locationState = .stopped
        default:
            manager.startUpdatingLocation()
            locationState = .locating
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        viewState = .error(error.localizedDescription)
        locationState = .stopped
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            if shouldRequestNewImage(location: currentLocation) {
                requestNewFlickrImage(location: currentLocation.coordinate)
            }
            print("Updated location to: \(currentLocation)")
        }
    }

    func shouldRequestNewImage(location: CLLocation) -> Bool {
        guard !downloadingImage else { return false }
        if images.isEmpty { return true }
        if let lastImage = images.first {
            let lastImageCoordinate = CLLocation(
                latitude: lastImage.latitude,
                longitude: lastImage.longitude
            )
            print("Distance form last image: \(location.distance(from: lastImageCoordinate)) meters")
            return location.distance(from: lastImageCoordinate) >= Constants.distanceNewPhoto
        }
        return true
    }
}
