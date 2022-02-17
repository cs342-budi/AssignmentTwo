//
//  LiveTherapyView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct LiveTherapyView: View {
    
    @ObservedObject var watchViewModel = WatchViewModel()
    
    var body: some View {
        // 1
        VStack{
            Text("My Live Therapy Tracker")
                .fontWeight(.heavy)
                .font(.title2)
                .foregroundColor(Color.black)
            
            Spacer()
            
            /* Text(watchViewModel.messageText)
                .font(.system(size: 50))
                .bold() */
            
            Button (action:{
                // MARK: TAYLOR
                // check if the watch is reachable
                if self.watchViewModel.session.isReachable {
                // send a message to the watch to stop the therapy session
                    self.watchViewModel.session.sendMessage(["action": "THERAPY_STOP"], replyHandler: nil, errorHandler: { (err) in
                        print(err.localizedDescription)
                    })
                }
                
            }) {
                Text("STOP THERAPY")
                    .fontWeight(.heavy)
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .padding()
            .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
            .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
            .background(Color.blue)
            .cornerRadius(10)
            
            Spacer()
            
            HStack {
                // 2
                ForEach(0..<12) { session in
                    // 3
                    VStack {
                        // 4
                        Spacer()
                        // 5
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 20, height: CGFloat(session) * 25)
                        // 6
                        Text("\(String(session))")
                            .font(.footnote)
                            .frame(height: 20)
                    }
                }
            }
        }
    }
}

struct LiveTherapyView_Previews: PreviewProvider {
    static var previews: some View {
        LiveTherapyView()
    }
}
