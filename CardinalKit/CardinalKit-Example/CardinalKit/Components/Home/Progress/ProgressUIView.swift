//
//  ProgressUIView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import CareKitStore
import CareKit
import Charts

struct ProgressUIView: View {
    
    // Dummy data
    let therapyProgress = [10, 20, 30, 40, 50]
    
    var body: some View {
        // 1
        VStack{
//            Text("My activity in the past 7 days")
//                .fontWeight(.heavy)
//                .font(.title2)
//                .foregroundColor(Color.black)
            
            Spacer()
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    Spacer()
                    ForEach(therapyProgress, id: \.self) { percent in
                        TherapyRingView(ringWidth: 5, percent: Double(percent),
                                        backgroundColor: Color.green.opacity(0.2),
                                        foregroundColors: [.blue, .green])
                            .frame(width: 55, height: 55)
                    }
                }
            }
            
            Spacer()
            
            ProgressUIChartView(entries: [
                //x - position of a bar, y - height of a bar
                BarChartDataEntry(x: 1, y: 1),
                BarChartDataEntry(x: 2, y: 2),
                BarChartDataEntry(x: 3, y: 3),
                BarChartDataEntry(x: 4, y: 4),
                BarChartDataEntry(x: 5, y: 5)
            ])
        }
    }
}
