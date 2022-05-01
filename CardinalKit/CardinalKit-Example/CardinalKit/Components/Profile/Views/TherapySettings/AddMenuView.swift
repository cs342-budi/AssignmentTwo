//
//  AddMenuView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/9/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import UIKit

struct DayElem : Identifiable, Hashable {
    let id = UUID()
    let day: String
}

private var week = [
    DayElem(day: "Monday"),
    DayElem(day: "Tuesday"),
    DayElem(day: "Wednesday"),
    DayElem(day: "Thursday"),
    DayElem(day: "Friday"),
    DayElem(day: "Saturday"),
    DayElem(day: "Sunday"),
]

struct AddMenuView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    //get existing schedule for each day
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
    //end schedule fetching -- move to helper function and return whole schedule object at once
    
    let storageController = ScheduleStorage()
    
    
    @State private var currentDate = Date()
    @State private var multiSelection = Set<UUID>()
    @ObservedObject var therapySchedule : TherapySchedule
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
                Spacer()
                Text("Add Therapy Session")
                    .font(.title3).bold()
                Spacer()
                Button(action: {
                    //Schedule notification
                    for d in week {
                        if multiSelection.contains(d.id) {
                            //update therapy schedule to reflect addition
                            storageController.printSched(schedule: monSched)
                            var components = Calendar.current.dateComponents([.hour, .minute], from: currentDate)
                            switch d.day {
                                case "Monday":
                                    let therapy = Monday(context: managedObjectContext)
                                    components.weekday = 2
                                    therapy.time = Calendar.current.date(from: components)
                                    PersistenceController.shared.save()
                                case "Tuesday":
                                    let therapy = Tuesday(context: managedObjectContext)
                                    components.weekday = 3
                                    therapy.time = Calendar.current.date(from: components)
                                    PersistenceController.shared.save()
                                case "Wednesday":
                                    let therapy = Wednesday(context: managedObjectContext)
                                    components.weekday = 4
                                    therapy.time = Calendar.current.date(from: components)
                                    PersistenceController.shared.save()
                                case "Thursday":
                                    let therapy = Thursday(context: managedObjectContext)
                                    components.weekday = 5
                                    therapy.time = Calendar.current.date(from: components)
                                    PersistenceController.shared.save()
                                case "Friday":
                                    let therapy = Friday(context: managedObjectContext)
                                    components.weekday = 6
                                    therapy.time = Calendar.current.date(from: components)
                                    PersistenceController.shared.save()
                                case "Saturday":
                                    let therapy = Saturday(context: managedObjectContext)
                                    components.weekday = 7
                                    print(components)
                                    therapy.time = Calendar.current.date(from: components)
                                    print(Calendar.current.date(from: components))
                                    PersistenceController.shared.save()
                                case "Sunday":
                                    let therapy = Sunday(context: managedObjectContext)
                                    components.weekday = 1
                                    therapy.time = Calendar.current.date(from: components)
                                    PersistenceController.shared.save()
                                default:
                                    print("Incorrect day")
                            }
                            let therapyScheduleController = TherapyScheduleViewController()
                            therapyScheduleController.scheduleLocal(day: d.day, time: currentDate)
//                            storageController.add(day: d.day, time: currentDate)
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save").bold()
                }
                
            }.padding(.leading)
                .padding(.trailing)
                .padding(.top)
            
            HStack{
                Spacer()
                DatePicker("", selection: $currentDate, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                Spacer()
            }
                
            Divider()

            NavigationView {
                VStack{
                    List(selection: $multiSelection) {
                        ForEach(week, id: \.id) { day in
                            Text("\(day.day)")
                                .font(.title3)
                                .padding()
                        }

                    }.environment(\.editMode, .constant(EditMode.active))
                        .navigationBarHidden(true)
                }
                
            }
            Spacer()
        }
    }
}


class ScheduleStorage {
    func add(day: String, time: Date) {
        @Environment(\.managedObjectContext) var managedObjectContext
        switch day {
            case "Monday":
                let therapy = Monday(context: managedObjectContext)
                therapy.time = time
                PersistenceController.shared.save()
            case "Tuesday":
                let therapy = Tuesday(context: managedObjectContext)
                therapy.time = time
                PersistenceController.shared.save()
            case "Wednesday":
                let therapy = Wednesday(context: managedObjectContext)
                therapy.time = time
                PersistenceController.shared.save()
            case "Thursday":
                let therapy = Thursday(context: managedObjectContext)
                therapy.time = time
                PersistenceController.shared.save()
            case "Friday":
                let therapy = Thursday(context: managedObjectContext)
                therapy.time = time
                PersistenceController.shared.save()
            default:
                print("Incorrect day")
        }
        let therapyScheduleController = TherapyScheduleViewController()
        therapyScheduleController.scheduleLocal(day: day, time: time)
    }
    
    func printSched(schedule: FetchedResults<Monday>) {
        for session in schedule {
            print(session.time)
        }
    }
}
