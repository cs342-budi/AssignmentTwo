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
            Spacer()
            Text("Therapy Rings")
                .fontWeight(.heavy)
                .font(.title2)
                .foregroundColor(Color.purple).navigationBarTitle("Your Progress")
            
            Spacer()
            
            //ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(dataViewModel.therapyProgress, id: \.self) { therapyProgress in
                        VStack {
                            TherapyRingView(ringWidth: 5, percent: therapyProgress.percent,
                                        backgroundColor: Color.purple.opacity(0.2),
                                        foregroundColors: [.purple, .purple])
                            //.frame(width: 55, height: 55)
                            Text(therapyProgress.date)
                                
                        }
                    }
                }.padding(.leading, 7)
                .padding(.trailing, 7)
                .frame(height: 75)
            //}
            Spacer()
            Text("Weekly Minutes of Therapy")
                .fontWeight(.heavy)
                .font(.title2)
                .foregroundColor(Color.blue)
                .padding(.top, 40)
            Spacer()
            ProgressUIChartView()
                .padding(.top, 20)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.bottom, 20)
                .overlay(Text("Active Tasks")
                .font(.system(size: 15))
                .fontWeight(.medium)
                .rotationEffect(.degrees(270))
                .offset(x: -20.0, y: 0.0),
                alignment: .leading)
                .overlay(Text("Days of the Week")
                .font(.system(size: 15))
                .fontWeight(.medium)
                .offset(x: 0.0, y: 5.0),
                alignment: .bottom)

            Spacer()
    
        }
    }
}
