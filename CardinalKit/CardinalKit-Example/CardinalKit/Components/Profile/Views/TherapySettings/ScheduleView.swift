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
    @Binding var showingSchedule : Bool
    @State private var showingAddMenu = false
  
    @StateObject var therapySchedule = TherapySchedule()
    @Environment(\.managedObjectContext) var managedObjectContext
    let persistentController = PersistenceController.shared
    
    let defaults = UserDefaults.standard
    @State var updater: Bool = false
    @State var showDeleteModal : Bool = false

    
    let therapyScheduleController = TherapyScheduleViewController()
  
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .center) {
                Spacer()
                Text("Cancel")
                    .foregroundColor(Color.green)
                    .onTapGesture(perform: {
                        showingSchedule = false
                    }).padding(.trailing)

            }.padding(.top)
            
            HStack {
                Spacer()
                Text("Therapy Schedule")
                    .font(.headline)
                Spacer()
            }
            
            .sheet(isPresented: $showingAddMenu) {
                AddMenuView(therapySchedule: therapySchedule, updateSchedule: $updater).environment(\.managedObjectContext, self.managedObjectContext)
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
                .padding(.leading, 15)
                .padding(.trailing, 15)
            }.sheet(isPresented: $showingAddMenu) {
                AddMenuView(therapySchedule: therapySchedule, updateSchedule: $updater)
            }
            if updater || !updater { //hacky way to ensure that it updates 
                List {
                    VStack (alignment: .leading){
                        Text("Mon")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(defaults.object(forKey: "Monday") as? [Date] ?? [Date](), id: \.self) { session in
                                    TimeBlock(time: session, day: "Monday", updater: $updater)
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Tues")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(defaults.object(forKey: "Tuesday") as? [Date] ?? [Date](), id: \.self) { session in
                                    TimeBlock(time: session, day: "Tuesday", updater: $updater) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Wed")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(defaults.object(forKey: "Wednesday") as? [Date] ?? [Date](), id: \.self) { session in
                                    TimeBlock(time: session, day: "Wednesday", updater: $updater) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Thurs")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(defaults.object(forKey: "Thursday") as? [Date] ?? [Date](), id: \.self) { session in
                                    TimeBlock(time: session, day: "Thursday", updater: $updater) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Fri")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(defaults.object(forKey: "Friday") as? [Date] ?? [Date](), id: \.self) { session in
                                    TimeBlock(time: session, day: "Friday", updater: $updater) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Sat")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(defaults.object(forKey: "Saturday") as? [Date] ?? [Date](), id: \.self) { session in
                                    TimeBlock(time: session, day: "Saturday", updater: $updater) //
                                }
                            }
                        }
                    }.padding()
                    VStack (alignment: .leading){
                        Text("Sun")
                            .font(.headline)
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(defaults.object(forKey: "Sunday") as? [Date] ?? [Date](), id: \.self) { session in
                                    TimeBlock(time: session, day: "Sunday", updater: $updater) //
                                }
                            }
                        }
                    }.padding()
                }.listStyle(PlainListStyle())
            }
        }.onAppear(perform: {
            if defaults.value(forKey: "defs") == nil { //if schedule defaults haven't been set yet
                let therapyScheduleController = TherapyScheduleViewController()
                
                //get yesterday
                var dayComponent = DateComponents()
                dayComponent.day = -1
                let calendar = Calendar.current
                let yesterday =  calendar.date(byAdding: dayComponent, to: Date())!
                
                for day in week {
                    //construct 4pm date time
                    var components = DateComponents()
                    components.calendar = Calendar.current
                    components.weekday = day.num
                    components.hour = 16 //4pm
                    var dateToReg = Calendar.current.nextDate(after: yesterday, matching: components, matchingPolicy: .nextTime)!
                    //store in user defaults
                    defaults.register(defaults: [
                        day.day : [dateToReg],
                    ])
                    
                    //schedule notification
                    therapyScheduleController.scheduleLocal(day: day.day, time: dateToReg)
                }
                defaults.set(true, forKey: "defs")
                updater.toggle()
            }

        })
    }
}

func getYesterday() -> Date {
    //get yesterday
    var dayComponent = DateComponents()
    dayComponent.day = -1
    let calendar = Calendar.current
    let yesterday =  calendar.date(byAdding: dayComponent, to: Date())!
    return yesterday 
}

func addDefaultToSchedule() {
    print("in func")
//    @Environment(\.managedObjectContext) var managedObjectContext
//    let persistentController = PersistenceController.shared
//
//    let schedOverview = Schedule(context: managedObjectContext)
//    schedOverview.set = true
//
//    let sun = DateComponents(hour: 16, weekday: 1) //4pm
//    let mon = DateComponents(hour: 16, weekday: 2) //4pm
//    let tue = DateComponents(hour: 16, weekday: 3) //4pm
//    let wed = DateComponents(hour: 16, weekday: 4) //4pm
//    let thurs = DateComponents(hour: 16, weekday: 5) //4pm
//    let fri = DateComponents(hour: 16, weekday: 6) //4pm
//    let sat = DateComponents(hour: 16, weekday: 7) //4pm
//
//    let sunObj = Sunday(context: managedObjectContext)
//    let monObj = Monday(context: managedObjectContext)
//    let tueObj = Tuesday(context: managedObjectContext)
//    let wedObj = Wednesday(context: managedObjectContext)
//    let thursObj = Thursday(context: managedObjectContext)
//    let friObj = Friday(context: managedObjectContext)
//    let satObj = Saturday(context: managedObjectContext)
//
//    sunObj.time = Calendar.current.date(from: sun)
//    monObj.time = Calendar.current.date(from: mon)
//    tueObj.time = Calendar.current.date(from:tue)
//    wedObj.time = Calendar.current.date(from: wed)
//    thursObj.time = Calendar.current.date(from:thurs)
//    friObj.time = Calendar.current.date(from:fri)
//    satObj.time = Calendar.current.date(from:sat)
//
//    persistentController.save()
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


