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
        
      
    let defaults = UserDefaults.standard
    let therapyGoal: Int

    let color: Color
    let config = CKPropertyReader(file: "CKConfiguration")
    let accent: Color

    var onComplete: (() -> Void)? = nil

    init(onComplete: (() -> Void)? = nil) {
        self.color = Color(config.readColor(query: "Primary Color"))
        self.accent = Color(config.readColor(query: "Accent Color"))
        self.therapyGoal = defaults.integer(forKey: "therapyGoal")
        
    }



    // Dummy data
    //    let therapyProgress = [10, 20, 30, 40, 50]

    var body: some View {
        // 1
        VStack{
            
                VStack (alignment: .leading) {
                    HStack {
                         Text("Today")
                            .font(.title2)
                            .fontWeight(.light)
                            
                        Text ("Monday, June 6")
                            .font(.title2)
                            .fontWeight(.thin)
                            .foregroundColor(self.color)
                            .frame(alignment: .trailing)
                            
                    }.foregroundColor(Color.black).navigationBarTitle("My Progress")
                        .padding(.top)
                        .padding(.leading)
                        .padding(.bottom, 5)
                                
                //ScrollView(.horizontal) {
              
                    HStack(spacing: 20) {
                        //ForEach(dataViewModel.therapyProgress, id: \.self) {therapyProgress in
                        VStack {
                                TherapyRingView(ringWidth: 30, percent: dataViewModel.todaysProgress.percent,
                                                backgroundColor: self.color.opacity(0.2),
                                                foregroundColors: [self.color, self.color])
                                //.frame(width: 55, height: 55)
                                
                        }
                        
                            VStack {
                                VStack {
                                    HStack {
                                        Text(String(Int(dataViewModel.todaysProgress.minsCompleted)))
                                            .font(.largeTitle)
                                            .bold()
                                            .italic()
                                            .foregroundColor(Color.green)
                                        Text(" / \(String(defaults.integer(forKey: "therapyGoal"))) min")
                                            .font(.headline)
                                            .bold()
                                            .foregroundColor(Color.gray)
                                    }

                                    VStack {
                                        Text("Today's progress")
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .foregroundColor(Color.gray)
                                    }
                                }.padding(.top)
                            .padding(.bottom, 5)
                            
                        
    //                        VStack {
    //                            Text("0")
    //                                .font(.largeTitle)
    //                                .bold()
    //                                .italic()
    //                                .foregroundColor(Color.green)
    //                            Text("Total score")
    //                                .font(.footnote)
    //                                .fontWeight(.semibold)
    //                                .foregroundColor(Color.gray)
    //                        }
                            }
                        
                        //}
                    }.padding(.leading, 7)
                    .padding(.trailing, 7)
                    .frame(height: 205)
                    
    //                    Text(dataViewModel.todaysProgress.date)
    //                        .font(.footnote)
    //                        .fontWeight(.semibold)
    //                        .foregroundColor(Color.gray)
    //                    Text(dataViewModel.todaysProgress.monthDate)
    //                        .font(.footnote)
    //                        .foregroundColor(Color.gray)
                
                }.frame(width: .infinity, alignment: .leading)
                .padding(.bottom)
                .padding(.trailing)
               
            Divider()
            Spacer()
            VStack (alignment: .leading){
                Text("Past 7 Days")
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundColor(Color.black)
                    .padding(.top)
                    .padding(.leading)

               // ProgressUIChartView()
                
                HStack (spacing: 16) {
                    BarView(val: 50, day: yesterDay(ind: -6))
                    BarView(val: 70, day: yesterDay(ind: -5))
                    BarView(val: 150, day: yesterDay(ind: -4))
                    BarView(val: 78, day: yesterDay(ind: -3))
                    BarView(val: 170, day: yesterDay(ind: -2))
                    BarView(val: 80, day: yesterDay(ind: -1))
                    BarView(val: 20, day: yesterDay(ind: 0))
                }.padding(.top, 24)
                
                
                    .padding(.top, 20)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.bottom, 20)
    //                    .overlay(Text("Therapy Time (min)")
    //                                .font(.footnote)
    //                                .fontWeight(.semibold).foregroundColor(Color.gray)
    //                    .rotationEffect(.degrees(270))
    //                    .offset(x: -36.0, y: 0.0),
    //                    alignment: .leading)
    //                    .overlay(Text("Day")
    //                                .font(.footnote)
    //                                .fontWeight(.semibold).foregroundColor(Color.gray)
    //                    .offset(x: 0.0, y: 5.0),
    //                    alignment: .bottom)
            }

            Spacer()

        }.onAppear(perform: {
            self.dataViewModel.getData()
        })
    }
    }

    struct BarView: View {
    var val: CGFloat = 0
    var day: String = ""
    var body: some View {
        
       //var style = StrokeStyle(lineWidth: 5)
       //style.dash = [1, 0.7]
        
        VStack{
            ZStack (alignment: .bottom) {
                Capsule().frame(width:30, height: 200)
                    .foregroundColor(.gray.opacity(0.1))
                Capsule().frame(width:30, height: val)
                    .foregroundColor(.green)
                    .overlay( Path() { path in
                        path.move(to: CGPoint(x:0, y: 0))
                        path.addLine(to: CGPoint(x: 30, y: 0))
                        }.stroke(Color.gray)
                    )
            }
            Text(day).padding(.top, 8)
                .font(.footnote)
                .foregroundColor(Color.gray)
        }
    }
    }


    func yesterDay(ind: Int) -> String {
    var dayComponent = DateComponents()
    dayComponent.day = ind
    let calendar = Calendar.current
    let nextDay =  calendar.date(byAdding: dayComponent, to: Date())!
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.dateFormat = "M/dd"
    return formatter.string(from: nextDay)
    }

    //struct Line: Shape {
    //    func path(in rect: CGRect) -> Path {
    //        var path = Path()
    //        path.move(to: CGPoint(x: 0, y: 0))
    //        path.addLine(to: CGPoint(x: rect.width, y: 0))
    //        return path
    //    }
    //}

    struct Previews_ProgressUIView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
    }
