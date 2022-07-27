//
//  LiveTherapyView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import CareKitStore
import CareKit
import Charts

struct LiveTherapyView: View {
    
    @ObservedObject var watchViewModel = WatchViewModel()
    @State private var showingTherapyVideos = false
    @Binding public var isLiveTherapyPresented: Bool
//    @State var exerciseCount = 0 //not in use
//    @State var points = 0
    @State var time = "2:37"
    
    var body: some View {
        
        // 1
        VStack (spacing: 0){
            Spacer(minLength: Metrics.PADDING_VERTICAL_MAIN*3)
            HStack (alignment: .bottom) {
                
                //MARK: Not including exercise tracking for beta release 
//                VStack {
//                    Text(String(exerciseCount))
//                        .font(.system(size: 24))
//                        .fontWeight(.bold)
//
//                    Text("Exercises")
//                        .font(.system(size: 13))
//                        .fontWeight(.light)
//                }
//                Spacer()
                

                ZStack {
                    ProgressBar(value: $watchViewModel.progressToNext).frame(width: UIScreen.main.bounds.size.width/1.5, height: 50)
                    
                        VStack {
                            Text(String(Int(watchViewModel.points)))
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                            Text("Points")
                                .font(.system(size: 13))
                                .fontWeight(.light)
                        }
                }
                Spacer()
                VStack{
                    TimerView(watchViewModel: watchViewModel)
                    Text("Time")
                        .font(.system(size: 13))
                        .fontWeight(.light)
                }
                
               

            }.padding([.top, .leading, .trailing])
            
            TherapyInstructionsView()
            
            Spacer()
            /*
            Text(watchViewModel.data).onReceive($watchViewModel.actionNotification){ action in
                // MARK: Taylor
                // We subscribe to *actionNotification* from the viewModel to listen for a notification
                // then based on the message we got, we either start or stop the therapy session.
                
                switch action {
                    case "data":
                        print("this is the change " + watchViewModel.data)
                    default:
                        return
                }
                
            }*/

            
//            Text("This is the data: \(watchViewModel.data)")
                
            // pass in array of max accelerations into LiveTherapyChartView
            LiveTherapyChartView(maxData: watchViewModel.maxReceived)
                .frame(width: 350, height: 210)
                .padding(.leading, 5)
                .padding(.trailing, 5)
                .padding(.bottom, 20)
            
            
            
            Text(watchViewModel.messageText)
                .font(.system(size: 50))
                .bold()
            
            HStack {
                Button (action:{
                    // MARK: TAYLOR
                    // check if the watch is reachable
                    if self.watchViewModel.session.isReachable {
                    // send a message to the watch to stop the therapy session
                        self.watchViewModel.session.sendMessage(["action": "THERAPY_STOP"], replyHandler: nil, errorHandler: { (err) in
                            print(err.localizedDescription)
                        })
                    }
                    
                    // Dismiss View
                    isLiveTherapyPresented = false
                    
                }) {
                    Text("Stop Therapy")
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding(Metrics.PADDING_VERTICAL_MAIN*1.75)
                .background(Color("SecondaryStop"))
                .cornerRadius(10)
                .padding()
                }
            Spacer(minLength: Metrics.PADDING_VERTICAL_MAIN*2)
        }.background(Color.green)
            .edgesIgnoringSafeArea(.all)
    }
}

