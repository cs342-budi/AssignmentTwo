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
    @State var showLaunchImage = true
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .overlay(
                        ZStack{
                            Image("budi-background")
                                .resizable()
                                .frame(width: 250.0, height: 250.0)
                        }
                            .opacity(showLaunchImage ? 1 : 0)
                            
                    )
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.showLaunchImage = false
                        }
                    }
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
