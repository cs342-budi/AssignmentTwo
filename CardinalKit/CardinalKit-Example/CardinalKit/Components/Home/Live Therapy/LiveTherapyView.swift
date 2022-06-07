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
//
//    @State var doubleQueue = Queue<Double>()
//
//    @StateObject var valuePublisher = ValuePublisher()
//
    @State private var showingTherapyVideos = false
    @Binding public var isLiveTherapyPresented: Bool
    @State var exerciseCount = 2
    @State var points = 11
    @State var time = "2:37"
    @State var progressValue: Float = 0.35
    
    var body: some View {
        
        // 1
        VStack{
            Spacer(minLength: Metrics.PADDING_VERTICAL_MAIN*2.5)
            HStack (alignment: .bottom) {
                VStack {
                    Text(String(exerciseCount))
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    
                    Text("Exercises")
                        .font(.system(size: 13))
                        .fontWeight(.light)
                }
                Spacer()
                VStack {
                    Text(String(points))
                        .font(.system(size: 44))
                        .fontWeight(.bold)
                    
                    Text("Points")
                        .font(.system(size: 13))
                        .fontWeight(.light)
                    
                }
                Spacer()
                VStack{
                    Text(String(time))
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    
                    Text("Time")
                        .font(.system(size: 13))
                        .fontWeight(.light)
                }
            }.padding([.leading, .trailing])
            VStack (alignment: .leading){
                ProgressBar(value: $progressValue).frame(height: 20)
                HStack {
                    Text(String(progressValue*100) + "%")
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                    Text("Progress to next point")
                        .font(.system(size: 13))
                        .fontWeight(.light)
                }
            }.padding()
            TherapyInstructionsView()
            
//            Text("My Live Therapy Tracker")
//                .fontWeight(.heavy)
//                .font(.title2)
//                .foregroundColor(Color.black)
//
//            Spacer()
//
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
                .frame(width: 350, height: 130)
                .padding(.leading, 5)
                .padding(.trailing, 5)
            

            
            Text(watchViewModel.messageText)
                .font(.system(size: 50))
                .bold()
            
            HStack {
                Spacer()
                
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
                Text("STOP THERAPY")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding(Metrics.PADDING_VERTICAL_MAIN*1.75)
            .background(Color("SecondaryStop"))
            .cornerRadius(10)
            .padding()
                
         
     
                Spacer()
            }
            Spacer(minLength: Metrics.PADDING_VERTICAL_MAIN*2)
        }.background(Color.green)
            .edgesIgnoringSafeArea(.all)
    }
}

