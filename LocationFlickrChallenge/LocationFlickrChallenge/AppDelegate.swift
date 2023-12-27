//
//  AppDelegate.swift
//  LocationFlickrChallenge
//
//  Created by Alex Morral on 31/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let flickrAPIKey = "462ec215f8d24fa488f88a24c397d270"
    let flickrAPISecret = "a24095a98d0c14d1"
    // https://live.staticflickr.com/{server-id}/{id}_{secret}_{size-suffix}.jpg
    // https://live.staticflickr.com/65535/52405204532_082f0f2a61.jpg

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

