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
import Foundation


class TherapySchedule : ObservableObject {
    @Published var schedule : [String: [Date]] = ["Monday":[], "Tuesday": [], "Wednesday": [], "Thursday":[], "Friday": [], "Saturday":[], "Sunday":[]]
}

struct ScheduleView: View {
    @State private var showingAddMenu = false
  
    @StateObject var therapySchedule = TherapySchedule()
    @Environment(\.managedObjectContext) var managedObjectContext
    
    //Get existing schedule
    @FetchRequest(entity: Monday.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Monday.time, ascending: true)])
    var monSched: FetchedResults<Monday>
    @FetchRequest(entity: Tuesday.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Tuesday.time, ascending: true)])
    var tuesSched: FetchedResults<Tuesday>
    @FetchRequest(entity: Wednesday.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Wednesday.time, ascending: true)])
    var wedSched: FetchedResults<Wednesday>
    @FetchRequest(entity: Thursday.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Thursday.time, ascending: true)])
    var thursSched: FetchedResults<Thursday>
    @FetchRequest(entity: Friday.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Friday.time, ascending: true)])
    var friSched: FetchedResults<Friday>
    @FetchRequest(entity: Saturday.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Saturday.time, ascending: true)])
    var satSched: FetchedResults<Saturday>
    @FetchRequest(entity: Sunday.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Sunday.time, ascending: true)])
    var sunSched: FetchedResults<Sunday>
    
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
                AddMenuView(therapySchedule: therapySchedule).environment(\.managedObjectContext, self.managedObjectContext)
            }
            
            Divider()
            
            Button(action: {
                self.showingAddMenu.toggle()
                NotificationControl.establishPermissions()
            }) {
                HStack(alignment: .center) {
                    Text("Add Session")
                        .fontWeight(.heavy)
                        .font(.title2)
                        .foregroundColor(Color.white)
                    Image("plus")
                }
                .frame(maxWidth: .infinity)
                .padding(Metrics.PADDING_VERTICAL_MAIN*3.2)
                .background(Color.green)
                .cornerRadius(10)
                .padding(.leading)
                .padding(.trailing)
            }.sheet(isPresented: $showingAddMenu) {
                AddMenuView(therapySchedule: therapySchedule)
            }
            
                List {
                    VStack (alignment: .leading){
                        Text("Mon")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(monSched, id: \.self) { session in
                                    TimeBlock(time: session.time ?? Date()) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Tues")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(tuesSched, id: \.self) { session in
                                    TimeBlock(time: session.time ?? Date()) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Wed")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(wedSched, id: \.self) { session in
                                    TimeBlock(time: session.time ?? Date()) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Thurs")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(thursSched, id: \.self) { session in
                                    TimeBlock(time: session.time ?? Date()) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Fri")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(friSched, id: \.self) { session in
                                    TimeBlock(time: session.time ?? Date()) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Sat")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(satSched, id: \.self) { session in
                                    TimeBlock(time: session.time ?? Date()) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Sun")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(sunSched, id: \.self) { session in
                                    TimeBlock(time: session.time ?? Date()) //
                                }
                            }
                        }
                    }.padding()
                }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}


class NotificationControl {
    static func establishPermissions() {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .authorized {
                // Notification permission granted, do nothing
            } else if settings.authorizationStatus == .denied {
                // Notification permission was previously denied, go to settings & privacy to re-enable
            } else if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        })
    }
}
