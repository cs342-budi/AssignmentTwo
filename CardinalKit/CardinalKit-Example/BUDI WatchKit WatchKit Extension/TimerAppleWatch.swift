//
//  TimerAppleWatch.swift
//  BUDI WatchKit WatchKit Extension
//
//  Created by Mihir Joshi on 6/25/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct TimerViewAppleWatch: View {
    @State public var workoutTime: Int
    var hours : Int {
        workoutTime / 3600
    }
    
    var minutes: Int {
        (workoutTime % 3600) / 60
    }
    
    var seconds: Int {
        workoutTime % 60
    }
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            workoutTime += 1
            
        }
    }
    
    var body: some View {
        HStack(spacing: 2) {
            if hours > 0 {
                StopwatchUnitView(timeUnit: hours)
                Text(":").font(.system(size: 20))
            }
            StopwatchUnitView(timeUnit: minutes)
            Text(":").font(.system(size: 20))
            StopwatchUnitView(timeUnit: seconds)
        }.onAppear(perform: {_ = timer})
        
    }
    
}

struct StopwatchUnitView: View {

    var timeUnit: Int

    /// Time unit expressed as String.
    /// - Includes "0" as prefix if this is less than 10
    var timeUnitStr: String {
        let timeUnitStr = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
    }

    var body: some View {
        HStack (spacing: 2) {
            Text(String(timeUnitStr.prefix(1)))
                .font(.system(size: 24))
                .fontWeight(.bold)
                .frame(width: 16)
             
            Text(String(timeUnitStr.suffix(1)))
                .font(.system(size: 24))
                .fontWeight(.bold)
                .frame(width: 16)
              
        }
    }
}
