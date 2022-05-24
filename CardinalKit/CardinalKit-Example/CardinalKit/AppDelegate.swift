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


// import facebook
import FBSDKCoreKit

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
        
        // Set up FB Sign In
        FBSDKCoreKit.ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
        
        return true
    }
    
    
    // Set up Google Sign In
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
          
          ApplicationDelegate.shared.application(
              application,
              open: url,
              sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
              annotation: options[UIApplication.OpenURLOptionsKey.annotation]
          )
          
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

extension AppDelegate: UNUserNotificationCenterDelegate{

  // This function will be called when the app receive notification
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      
    // show the notification alert (banner), and with sound
      completionHandler([.sound,.banner])
  }
    
  // This function will be called right after user tap on the notification
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      
      let application = UIApplication.shared
      
      if(application.applicationState == .active){
        print("user tapped the notification bar when the app is in foreground")
        
      }
      
      if(application.applicationState == .inactive)
      {
        print("user tapped the notification bar when the app is in background")
      }
      
      /* Change root view controller to a specific viewcontroller */
      // let storyboard = UIStoryboard(name: "Main", bundle: nil)
      // let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerStoryboardID") as? ViewController
      // self.window?.rootViewController = vc
      
      
    // tell the app that we have finished processing the user’s action / response
    completionHandler()
  }
}


