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
]

struct AddMenuView: View {
    
    @State private var currentDate = Date()
    @State private var multiSelection = Set<UUID>()
    let therapyScheduleController = TherapyScheduleViewController()
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
                    var selected_days: [String] = []
                    for d in week {
                        if multiSelection.contains(d.id) {
                            selected_days.append(d.day)
                        }
                    }
                    therapyScheduleController.scheduleLocal(days: selected_days, time: currentDate)
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
                
//            VStack{
//                Button(action:{}) {
//                    Text("Monday")
//                        .foregroundColor(Color.white)
//                        .fontWeight(.bold)
//                        .padding()
//
//                }.frame(maxWidth: .infinity)
//                    .background(Color.init(UIColor.lightGray))
//
//            }.padding(.leading)
//                .padding(.trailing)
            Spacer()
        }
    }
}



struct AddMenuView_Previews: PreviewProvider {
    static var previews: some View {
        AddMenuView()
    }
}
