//
//  ScheduleView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/9/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation

//store in map? store in list/array?

struct ScheduleView: View {
    @State private var showingAddMenu = false
    
    let therapyScheduleController = TherapyScheduleViewController()
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {

                Spacer()
                Text("Therapy Schedule")
                    .font(.title2)
                Spacer()

            }.padding(.leading)
                .padding(.trailing)
                .padding(.top)
            
            .sheet(isPresented: $showingAddMenu) {
                    AddMenuView()
            }
            
            Divider()
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }.padding()
            
            
            Button("Schedule Notification") {
                therapyScheduleController.scheduleLocal()
            }.padding()
            
            AddBlockButtonView()
                    .gesture(TapGesture().onEnded({
                self.showingAddMenu.toggle()
                    
            })).sheet(isPresented: $showingAddMenu, onDismiss: {
            }, content: {
                AddMenuView()
            })
            
            ScrollView {
                VStack (alignment: .leading) {
                Group {
                    Group {
                        Text("Mon")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading)
                            
                        ScrollView (.horizontal){
                            HStack {
                            TimeBlock(time:"11:00", ampm:"AM")
                            
                            TimeBlock(time:"4:00", ampm:"PM")

                            }
                        }.padding(.leading)
                        Divider()
                    }
                    
                    Group {
                        Text("Tues")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        ScrollView (.horizontal){
                            HStack {
                                TimeBlock(time:"8:00", ampm:"AM")
                                
                                TimeBlock(time:"11:00", ampm:"AM")
                                TimeBlock(time:"5:00", ampm:"PM")
                                TimeBlock(time: "8:00", ampm: "PM")
                                      
                            }.padding(.leading)
                        }
                        Divider()
                    }
                    
                    Group {
                        Text("Wed")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        ScrollView (.horizontal){
                            HStack {
                                TimeBlock(time:"8:00", ampm:"AM")
 
                            }.padding(.leading)
                            
                        }
                        Divider()
                    }
                    Group {
                        Text("Thurs")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        ScrollView (.horizontal){
                            HStack {
                                TimeBlock(time:"5:00", ampm:"PM")
                                TimeBlock(time: "8:00", ampm: "PM")

                            }.padding(.leading)
                        }
                        Divider()
                    }
                    Group {
                        Text("Fri")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        ScrollView (.horizontal){
                            HStack {
    
                            }.padding(.leading)
                        }
                        Divider()
                    }
                    Group {
                        Text("Sat")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        ScrollView (.horizontal){
                            HStack {
                                TimeBlock(time:"11:00", ampm:"AM")
                
                            }.padding(.leading)
                        }
                        Divider()
                    }
                    Group {
                        Text("Sun")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        ScrollView (.horizontal){
                            HStack {
                                TimeBlock(time:"8:00", ampm:"AM")
                                
                                TimeBlock(time:"11:00", ampm:"AM")
                                
                          
                             
                            }.padding(.leading)
                        }
                        Divider()
                    }
                }
                }
            }
            Spacer()
        }
       
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

