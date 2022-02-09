//
//  AddMenuView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/9/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import UIKit

struct DayElem : Identifiable {
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
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack{
                Button(action: {}) {
                    Text("Cancel")
                }
                Spacer()
                Text("Add Therapy Session")
                    .font(.title3).bold()
                Spacer()
                Button(action: {}) {
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
            Text("Select Days")
                .font(.headline)
                .padding(.leading)
            
            NavigationView {
                List(week, selection: $multiSelection) {
                    Text($0.day)
                        .font(.title3)
                        .padding()
                }.environment(\.editMode, .constant(EditMode.active))
                    .navigationBarHidden(true)
                
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
