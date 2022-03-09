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
    
    let color: Color
    let config = CKPropertyReader(file: "CKConfiguration")
    let accent: Color
    
    var onComplete: (() -> Void)? = nil
    
    init(onComplete: (() -> Void)? = nil) {
        self.color = Color(config.readColor(query: "Primary Color"))
        self.accent = Color(config.readColor(query: "Accent Color"))
        
    }
    
    
    // Dummy data
//    let therapyProgress = [10, 20, 30, 40, 50]
    
    var body: some View {
        // 1
        VStack{
          
                VStack (alignment: .leading) {
                Text("Daily Therapy Goal")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black).navigationBarTitle("My Progress")
                    .padding(.top)
                    .padding(.leading)
                    .padding(.bottom, 5)
                
                                
                //ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(dataViewModel.therapyProgress, id: \.self) { therapyProgress in
                            VStack {
                                TherapyRingView(ringWidth: 5, percent: therapyProgress.percent,
                                                backgroundColor: self.accent.opacity(0.2),
                                                foregroundColors: [self.accent, self.accent])
                                //.frame(width: 55, height: 55)
                                Text(therapyProgress.date)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                Text(therapyProgress.monthDate)
                                    .font(.footnote)
                                    .foregroundColor(Color.gray)
                                    
                            }
                        }
                    }.padding(.leading, 7)
                    .padding(.trailing, 7)
                    .frame(height: 75)
                //}
                }.frame(width: .infinity, alignment: .leading)
            
            Spacer()
            Divider()
            Spacer()
            VStack (alignment: .leading){
                Text("Total Therapy This Week")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(.top)
                    .padding(.leading)
    
                ProgressUIChartView()
                    .padding(.top, 20)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.bottom, 20)
                    .overlay(Text("Therapy Time (min)")
                                .font(.footnote)
                                .fontWeight(.semibold).foregroundColor(Color.gray)
                    .rotationEffect(.degrees(270))
                    .offset(x: -36.0, y: 0.0),
                    alignment: .leading)
                    .overlay(Text("Day")
                                .font(.footnote)
                                .fontWeight(.semibold).foregroundColor(Color.gray)
                    .offset(x: 0.0, y: 5.0),
                    alignment: .bottom)
            }

            Spacer()
    
        }
    }
}
