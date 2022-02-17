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
    
    func scheduleLocal() {
        registerCategories()
        let content = UNMutableNotificationContent()
        content.title = "It's therapy time!"
        content.body = "Open BUDI to get started."
        content.sound = UNNotificationSound.default
        content.launchImageName = "AppIcon"
        content.categoryIdentifier = "startTherapy"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content,   trigger: trigger)
        
        
       
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
        let sceneDel = SceneDelegate()
        
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
    
}
