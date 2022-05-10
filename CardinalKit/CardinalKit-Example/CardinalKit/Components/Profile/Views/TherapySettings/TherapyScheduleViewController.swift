//
//  ScheduleViewController.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/16/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit


class TherapyScheduleViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    func scheduleLocal(day: String, time: Date) {
        registerCategories()
        let content = UNMutableNotificationContent()
        content.title = "It's therapy time!"
        content.body = "Open BUDI to get started."
        content.sound = UNNotificationSound.default
        content.launchImageName = "AppIcon"
        content.categoryIdentifier = "startTherapy"
        
        let dateComp = Calendar.current.dateComponents([.weekday, .hour,
                                                        .minute], from: time)
        print(dateComp)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let startSession = UNNotificationAction(identifier: "start", title: "Start a Therapy Session", options: [])
        let category = UNNotificationCategory(identifier: "startTherapy", actions: [startSession], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options:.customDismissAction)
        center.setNotificationCategories([category])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //let userInfo = response.notification.request.content.userInfo
       // let sceneDel = SceneDelegate()
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier : //user swiped to unlock
            print ("default identifier")
        case "start" :
            print("start therapy")
            //code to open to a specific scene
        default :
            break
        }
        completionHandler()
    }
    
    func establishPermissions() {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .authorized {
                // Notification permission granted, do nothing
            } else if settings.authorizationStatus == .denied {
                // Notification permission was previously denied, go to settings & privacy to re-enable
            } else if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        })
    }
    
}
