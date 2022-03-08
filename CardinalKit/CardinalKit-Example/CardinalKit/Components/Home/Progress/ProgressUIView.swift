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
    @ObservedObject var dataViewModel = ProgressUIChartViewModel()
    
    // Dummy data
//    let therapyProgress = [10, 20, 30, 40, 50]
    
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
                    ForEach(dataViewModel.therapyProgress, id: \.self) { percent in
                        TherapyRingView(ringWidth: 5, percent: Double(percent),
                                        backgroundColor: Color.green.opacity(0.2),
                                        foregroundColors: [.blue, .green])
                            .frame(width: 55, height: 55)
                    }
                }
            }
            ProgressUIChartView()
                .padding(.top, 20)
                .padding(.leading, 70)
                .overlay(Text("Games Completed")
                .font(.system(size: 15))
                .fontWeight(.medium)
                .rotationEffect(.degrees(270))
                .offset(x: -10.0, y: 0.0),
                alignment: .leading)
                .overlay(Text("Days of the Week")
                .font(.system(size: 15))
                .fontWeight(.medium)
                .offset(x: 10.0, y: 0.0),
                alignment: .bottom)

            Spacer()
    
        }
    }
}
