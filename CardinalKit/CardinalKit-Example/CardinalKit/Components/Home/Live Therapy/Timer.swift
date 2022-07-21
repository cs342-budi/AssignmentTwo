//
//  Timer.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 6/20/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

struct TimerView: View {

    @ObservedObject var watchViewModel = WatchViewModel()

    var body: some View {
        HStack(spacing: 2) {
            StopwatchView(pauseMessage: $watchViewModel.pauseMessage)
        }
        
    }
    
}

struct StopwatchView: View {
    
    @Binding var pauseMessage : String
    @State var workoutTime:Int = 0
    
    var body: some View {
        Group {
            if (workoutTime / 3600) > 0 {
                StopwatchUnitView(timeUnit: workoutTime / 3600)
                Text(":").font(.system(size: 20))
            }
            StopwatchUnitView(timeUnit: (workoutTime % 3600) / 60)
            Text(":").font(.system(size: 20))
            StopwatchUnitView(timeUnit: workoutTime % 60)
        }
        .onAppear {
           stopwatch()
        }
    }
    
    func stopwatch() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ currTime in
            switch pauseMessage {
            case "RESUME":
                self.workoutTime += 1
            case "PAUSE":
                print("timer_paused")
            case "STOP":
                currTime.invalidate()
                self.workoutTime = 0
            default:
                print("default")
            }
            
        }
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


