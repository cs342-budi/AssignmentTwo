//
//  DeleteModalView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 5/16/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct DeleteModalView: View {
    @Binding var isPresented : Bool
    var day: String
    var time: Date
    @Binding var updater : Bool
    
    let defaults = UserDefaults.standard
  
  var body: some View {
      VStack {
          HStack {
              Spacer()
              Button(action: {
                isPresented = false
              }, label: {
                Text("Cancel")
                      .foregroundColor(Color.green)
              })
          }.padding([.trailing, .top])
          
          VStack  {
              Text("Remove this therapy session?")
                  .font(.title3)
                  .fontWeight(.bold)
                  .padding([.top, .leading, .trailing])
                  .padding(.bottom, 3)
              
              HStack {
                  Text(day)
                      .font(.title3)
                      .fontWeight(.bold)
                   
                      
                  Text(time, style: .time)
                      .font(.title3)
                  
              }.padding()
              
          }.padding([.bottom])
              
          
          VStack {
              VStack {
                  Button(action: { //delete
                      var currSched = defaults.object(forKey: day) as? [Date] ?? [Date]()
                      let sched = currSched.filter { $0 != time }
                      defaults.set(sched, forKey: day)
                      
                      //Cancel local notification (for now cancel all & update all)
                      handleNotificationDelete()
                      
                      updater.toggle()
                      isPresented = false 
                  }, label: {
                          Text("Yes, delete session.")
                                .fontWeight(.bold)
                              .padding(Metrics.PADDING_VERTICAL_MAIN*2)
                              .frame(width: 250)
                              .background(Color.green)
                              .foregroundColor(Color.white)
                              .frame(width: 250)
                              .cornerRadius(12)
                      
                  }).padding(.bottom)
                  
                  Button(action: { //delete
                    isPresented = false
                  }, label: {
                      Text("No, keep session.")
                          .padding(Metrics.PADDING_VERTICAL_MAIN*2)
                          .frame(width: 250)
                          .background(Color.gray)
                          .foregroundColor(Color.white)
                          .cornerRadius(12)
                  })
                  .padding(.top)
                  Spacer()
              }
              Spacer()
          }
          
      }
  }
}

func handleNotificationDelete () {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    let defaults = UserDefaults.standard
    let therapyScheduleController = TherapyScheduleViewController()
    for day in week {
        let dayArr = defaults.object(forKey: day.day) as? [Date] ?? [Date]()
        for session in dayArr {
            therapyScheduleController.scheduleLocal(day: day.day, time: session)
        }
    }
}
