//
//  TherapyInstructionsView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 3/5/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import AVKit
import AVFoundation

struct TherapyInstructionsView: View {
    var body: some View {
        VStack {
            Text("Therapy Exercises")
                .font(.title2)
                .padding(.top)
                
            ScrollView {
                
                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "armAcrossBody", withExtension: "mov")!))
                    .frame(height: 202)
                    .padding(.bottom)
                
                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "armOutCropped", withExtension: "mov")!))
                    .frame(height: 202)
                    .padding(.bottom)
                
                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "armUpCropped", withExtension: "mov")!))
                    .frame(height: 202)
                    .padding(.bottom)
                

                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "forwardArmCircles", withExtension: "mov")!))
                    .frame(height: 202)
                    .padding(.bottom)
                
 ///                note: removed since we don't have animated version.
//                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "backCircles", withExtension: "mov")!))
//                    .frame(height: 202)
//                    .padding(.bottom)
                
                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "upDownmov", withExtension: "mov")!))
                    .frame(height: 202)
                    .padding(.bottom)
                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "pushUpWallmov", withExtension: "mov")!))
                    .frame(height: 202)
                    .padding(.bottom)
                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "fingers", withExtension: "mov")!))
                    .frame(height: 202)
                    .padding(.bottom)
                VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "squeeze", withExtension: "mov")!))
                    .frame(height: 202)
                    .padding(.bottom)
            }.padding()
        }
    }
}

struct TherapyInstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        TherapyInstructionsView()
    }
}
