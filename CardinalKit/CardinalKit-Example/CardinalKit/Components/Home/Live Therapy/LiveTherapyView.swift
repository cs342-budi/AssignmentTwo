//
//  LiveTherapyView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import CareKitStore
import CareKit
import Charts

struct LiveTherapyView: View {
    
    @ObservedObject var watchViewModel = WatchViewModel()
    
    var body: some View {
        // 1
        VStack{
            Text("My Live Therapy Tracker")
                .fontWeight(.heavy)
                .font(.title2)
                .foregroundColor(Color.black)
            
            Spacer()
            LiveTherapyChartView(entries: [
                //x - position of a bar, y - height of a bar
                ChartDataEntry(x: 1, y: 1),
                ChartDataEntry(x: 2, y: 2),
                ChartDataEntry(x: 3, y: 3),
                ChartDataEntry(x: 4, y: 4),
                ChartDataEntry(x: 5, y: 5)
            ])
                .padding(.top, 30 )
                .padding(.leading, 30)
                .overlay(Text("Time")
                .font(.system(size: 15))
                .fontWeight(.medium)
                .rotationEffect(.degrees(270))
                .offset(x: 0.0, y: 0.0),
                alignment: .leading)
                .overlay(Text("Acceleration")
                .font(.system(size: 15))
                .fontWeight(.medium)
                .offset(x: 0, y: 0),
                alignment: .top)
            Text(watchViewModel.messageText)
                .font(.system(size: 50))
                .bold()
            
            Spacer()
        }
    }
}

