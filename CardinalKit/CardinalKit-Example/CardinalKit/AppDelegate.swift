//
//  AppDelegate.swift
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//
import UIKit
import Firebase
import ResearchKit
import SwiftUI
import Foundation
import CoreData
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        // (1) initialize Firebase SDK
        FirebaseApp.configure()
        
        // (2) check if this is the first time
        // that the app runs!
        cleanIfFirstRun()
    
        // (3) initialize CardinalKit API
        CKAppLaunch()
        
        
        let config = CKPropertyReader(file: "CKConfiguration")
        UIView.appearance(whenContainedInInstancesOf: [ORKTaskViewController.self]).tintColor = config.readColor(query: "Tint Color")
        
        // Fix transparent navbar in iOS 15
               if #available(iOS 15, *) {
                   let appearance = UINavigationBarAppearance()
                   appearance.configureWithOpaqueBackground()
                   UINavigationBar.appearance().standardAppearance = appearance
                   UINavigationBar.appearance().scrollEdgeAppearance = appearance
               }
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    
    // Set up Google Sign In
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
          
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
}

extension AppDelegate : UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("in will present")
        completionHandler([.banner, .badge, .sound])
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("user notification center received \(response)")
        completionHandler()
    }
}

// Extensions add new functionality to an existing class, structure, enumeration, or protocol type.
// https://docs.swift.org/swift-book/LanguageGuide/Extensions.html
extension AppDelegate {
    
    /**
     The first time that our app runs we have to make sure that :
     (1) no passcode remains stored in the keychain &
     (2) we are fully signed out from Firebase.
     
     This step is required as an edge-case, since
     keychain items persist after uninstallation.
    */
    fileprivate func cleanIfFirstRun() {
        if !UserDefaults.standard.bool(forKey: Constants.prefFirstRunWasMarked) {
            if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
                ORKPasscodeViewController.removePasscodeFromKeychain()
            }
            try? Auth.auth().signOut()
            UserDefaults.standard.set(true, forKey: Constants.prefFirstRunWasMarked)
        }
    }
    
}




