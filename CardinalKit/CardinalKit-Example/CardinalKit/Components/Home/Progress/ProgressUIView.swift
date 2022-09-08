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
    let color_bkg: Color

    var onComplete: (() -> Void)? = nil

    init(onComplete: (() -> Void)? = nil) {
        self.color = Color(config.readColor(query: "Primary Color"))
        self.accent = Color(config.readColor(query: "Accent Color"))
        self.therapyGoal = defaults.integer(forKey: "therapyGoal")
        self.color_bkg = Color.gray
    }



    // Dummy data
    //    let therapyProgress = [10, 20, 30, 40, 50]

    var body: some View {
        
      
        VStack {
                VStack {
                    
                    HStack {
                        
                        Text("Today")
                            .font(.title2)
                            .fontWeight(.light)
                       
                        Text (toDay(ind: 0))
                            .font(.title2)
                            .fontWeight(.thin)
                            .foregroundColor(self.color)
                    }
                
                    HStack {
                        TherapyRingView(ringWidth: 30, percent: dataViewModel.todaysProgress.percent*100,
                                                backgroundColor: self.color_bkg.opacity(0.2),
                                                foregroundColors: [self.color, self.color])
                    
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

                                   
                                Text("Today's progress")
                                        .font(.footnote)
                                        .fontWeight(.thin)
                                        .foregroundColor(Color.gray)
                                   
                                }
                            
                        }
                
                    }.padding(.bottom)
                    //.navigationBarTitleDisplayMode(.inline)
                
            Divider()
            Spacer()
            
            
            VStack {
                Text("Past 7 Days")
                        .font(.title2)
                        .fontWeight(.light)
                        .foregroundColor(Color.black)
                        .padding(.top)
                        .padding(.leading)
                       
                HStack {
                    BarView(val: dataViewModel.day6Progress.percent, date: yesterDay(ind: -6), letterDay: letterDay(ind: -6))
                    BarView(val: dataViewModel.day5Progress.percent, date: yesterDay(ind: -5), letterDay: letterDay(ind: -5))
                    BarView(val: dataViewModel.day4Progress.percent, date: yesterDay(ind: -4), letterDay: letterDay(ind: -4))
                    BarView(val: dataViewModel.day3Progress.percent, date: yesterDay(ind: -3), letterDay: letterDay(ind: -3))
                    BarView(val: dataViewModel.day2Progress.percent, date: yesterDay(ind: -2), letterDay: letterDay(ind: -2))
                    BarView(val: dataViewModel.day1Progress.percent, date: yesterDay(ind: -1), letterDay: letterDay(ind: -1))
                    BarView(val: dataViewModel.day0Progress.percent, date: yesterDay(ind: 0), letterDay: letterDay(ind: 0))
                                                               
                }
            }.padding(.bottom)
           
            Spacer()

        }.onAppear(perform: {
            self.dataViewModel.getData()
            print(dataViewModel.therapyProgress)
            })
      
    }
    
}

    struct BarView: View {
    var val: CGFloat = 0
    var date: String = ""
    var letterDay: String = ""
    var body: some View {
        
       //var style = StrokeStyle(lineWidth: 5)
       //style.dash = [1, 0.7]
        
        VStack{
            ZStack (alignment: .bottom) {
                Capsule().frame(width:35, height: 300)
                    .foregroundColor(.gray.opacity(0.1))
                Capsule().frame(width:35, height: val*300)
                    .foregroundColor(.green)
                // this is Average dashed line
//                    .overlay( Path() { path in
//                        path.move(to: CGPoint(x:0, y: 0))
//                        path.addLine(to: CGPoint(x: 30, y: 0))
//                        }.stroke(Color.gray)
                    
            }
            Text(letterDay).padding(.top, 8)
                .font(.footnote)
                .foregroundColor(Color.green)
            Text(date).font(.footnote)
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
    
    func letterDay(ind: Int) -> String {
        var dayComponent = DateComponents()
        dayComponent.day = ind
        let calendar = Calendar.current
        let nextDay =  calendar.date(byAdding: dayComponent, to: Date())!
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "E"
        let getDay = formatter.string(from: nextDay)
        if getDay == "Mon"{
            return "M"
        } else if getDay == "Tue" {
            return "T"
        } else if getDay == "Wed" {
            return "W"
        } else if getDay == "Thu" {
            return "T"
        } else if getDay == "Fri" {
            return "F"
        }
        return "S"
    }

    func toDay(ind: Int) -> String {
        var dayComponent = DateComponents()
        dayComponent.day = ind
        let calendar = Calendar.current
        let nextDay =  calendar.date(byAdding: dayComponent, to: Date())!
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: nextDay)
    }

//    struct Line: Shape {
//        func path(in rect: CGRect) -> Path {
//            var path = Path()
//            path.move(to: CGPoint(x: 0, y: 0))
//            path.addLine(to: CGPoint(x: rect.width, y: 0))
//            return path
//        }
//    }

    struct Previews_ProgressUIView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
    }
    

