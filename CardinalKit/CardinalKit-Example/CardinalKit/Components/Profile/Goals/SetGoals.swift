//
//  SetGoals.swift
//  CardinalKit_Example
//
//  Created by Beste Aydin on 3/1/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct SetGoals: View {
   
    @AppStorage("TherapyGoal") private var therapyGoal = "10"
    @AppStorage("ActiveGoal") private var activeGoal = "3"
    let defaults = UserDefaults.standard

   
    var body: some View {
        VStack {
            Text("Set Daily Goals")
                .font(.title)
                .fontWeight(.heavy)
                .tracking(/*@START_MENU_TOKEN@*/2.0/*@END_MENU_TOKEN@*/)
            Text("Tap a number to edit it")
                .font(.body)
                .fontWeight(.light)
                .italic()
                .padding(.bottom)
            HStack {
                VStack(alignment: .leading){
                    Text("Therapy")
                        .font(.title)
                        .fontWeight(.medium)
                        .tracking(/*@START_MENU_TOKEN@*/2.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.black)
                        //.padding(.bottom, 1.0)
                    HStack {
                        TextField("\(therapyGoal)", text: $therapyGoal)
                            .keyboardType(.numberPad)
                        Text("min")
                            .padding(.trailing, 40.0)
                    }
                    .padding(.bottom, 20.0)
                    .font(.largeTitle)
                    .foregroundColor(Color.green)
                }
            }
            .padding(.horizontal, 50.0)
            HStack {
                VStack(alignment: .leading){
                    Text("Active Tasks")
                        .font(.title)
                        .fontWeight(.medium)
                        .tracking(/*@START_MENU_TOKEN@*/2.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.black)
                        //.padding(.bottom, 1.0)
                    TextField("\(activeGoal)", text: $activeGoal)
                        .keyboardType(.numberPad)
                }
                .font(.largeTitle)
                .foregroundColor(Color.yellow)
            }
            
            .padding(.horizontal, 50.0)
        }
        .onAppear(perform: {
            print(self.therapyGoal)
            print(self.activeGoal)
        })
        .onDisappear(perform: {
            defaults.set(Int(therapyGoal), forKey: "therapyGoal")
            defaults.set(Int(activeGoal), forKey: "activeGoal")
        })
    }
}

struct SetGoals_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SetGoals()
        }
    }
}
