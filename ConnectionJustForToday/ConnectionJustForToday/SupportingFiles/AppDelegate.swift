//
//  AppDelegate.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/29/23.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        JFTMockModelController.sharedInstance.createJFT(title: "Vigilance", date: "January 1", quote: "We keep what we have only with vigilance... Basic Text, p. 57", body: "How do we remain vigilant about our recovery? First, by realizing that we have a disease we will always have. No matter how long we've been clean, no matter how much better our lives have become, no matter what the extent of our spiritual healing, we are still addicts. Our disease waits patiently, ready to spring the trap if we give it the opportunity.", aspiration: "Just for today: I will be vigilant, doing everything necessary to guard my recovery.")
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

