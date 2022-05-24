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
    let num : Int
}

var week = [
    DayElem(day: "Monday", num: 2),
    DayElem(day: "Tuesday", num: 3),
    DayElem(day: "Wednesday", num: 4),
    DayElem(day: "Thursday", num: 5),
    DayElem(day: "Friday", num: 6),
    DayElem(day: "Saturday", num: 7),
    DayElem(day: "Sunday", num: 1),
]

struct AddMenuView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let defaults = UserDefaults.standard


    
    @State private var currentDate = Date()
    @State private var multiSelection = Set<UUID>()
    @ObservedObject var therapySchedule : TherapySchedule
    @Binding var updateSchedule: Bool
    let therapyScheduleController = TherapyScheduleViewController()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(Color.green)
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
                            var components = Calendar.current.dateComponents([.hour, .minute], from: currentDate)
                            components.weekday = d.num 
                            //get existing array from user defaults for that day, d.day
                            var array : [Date] = defaults.object(forKey: d.day) as? [Date] ?? [Date]()
                            if let newDate = Calendar.current.nextDate(after: getYesterday(), matching: components, matchingPolicy: .nextTime){
                                //append element
                                array.append(newDate)
                                array.sort(){$0 < $1}
                                
                                //save
                                defaults.set(array, forKey: d.day)
                                therapyScheduleController.scheduleLocal(day: d.day, time: newDate)
                            }
                            updateSchedule.toggle()
                            }
                        }
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save").bold()
                        .foregroundColor(Color.green)
                })
                
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


//class ScheduleStorage {
//    func add(day: String, time: Date) {
//        @Environment(\.managedObjectContext) var managedObjectContext
//        switch day {
//            case "Monday":
//                let therapy = Monday(context: managedObjectContext)
//                therapy.time = time
//                PersistenceController.shared.save()
//            case "Tuesday":
//                let therapy = Tuesday(context: managedObjectContext)
//                therapy.time = time
//                PersistenceController.shared.save()
//            case "Wednesday":
//                let therapy = Wednesday(context: managedObjectContext)
//                therapy.time = time
//                PersistenceController.shared.save()
//            case "Thursday":
//                let therapy = Thursday(context: managedObjectContext)
//                therapy.time = time
//                PersistenceController.shared.save()
//            case "Friday":
//                let therapy = Thursday(context: managedObjectContext)
//                therapy.time = time
//                PersistenceController.shared.save()
//            default:
//                print("Incorrect day")
//        }
//        let therapyScheduleController = TherapyScheduleViewController()
//        therapyScheduleController.scheduleLocal(day: day, time: time)
//    }
//
//    func printSched(schedule: FetchedResults<Monday>) {
//        for session in schedule {
//            print(session.time)
//        }
//    }
// }
