//
//  CardinalKitApp.swift
//  BUDI WatchKit WatchKit Extension
//
//  Created by billzhu on 2/3/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

@main
struct CardinalKitApp: App {
    @StateObject var workoutManager = WorkoutManager()
    @StateObject var cmMotionManager = CoreMotionManager()
    
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .sheet(isPresented: $workoutManager.showingSummaryView) {
                SummaryView()
            }
            .environmentObject(workoutManager)
            .environmentObject(cmMotionManager)
            
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
