//
//  TherapyInstructionsView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 3/5/22.
//  Modified by Mihir Joshi on 4/29/22
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import AVKit
import AVFoundation

struct Instruction: Identifiable {
    var id = UUID()
    var video: URL
    var title: String
    var tag: Int
}

extension Instruction {
    static let videos = [
        Instruction(video: Bundle.main.url(forResource: "armAcrossBody", withExtension: "mov")!, title: "Arm Across Body", tag: 0),
        Instruction(video: Bundle.main.url(forResource: "armOutCropped", withExtension: "mov")!, title: "Arm Out", tag: 1),
        Instruction(video: Bundle.main.url(forResource: "armUpCropped", withExtension: "mov")!, title: "Arm Up", tag: 2),
        Instruction(video: Bundle.main.url(forResource: "forwardArmCircles", withExtension: "mov")!, title: "Forward Arm Circles", tag: 3),
        Instruction(video: Bundle.main.url(forResource: "backCircles", withExtension: "mov")!, title: "Back Circles", tag: 4),
        Instruction(video: Bundle.main.url(forResource: "upDownmov", withExtension: "mov")!, title: "Up Down", tag: 5),
        Instruction(video: Bundle.main.url(forResource: "pushUpWallmov", withExtension: "mov")!, title: "Push Up Wall", tag: 6),
        Instruction(video: Bundle.main.url(forResource: "fingers", withExtension: "mov")!, title: "Fingers", tag: 7),
        Instruction(video: Bundle.main.url(forResource: "squeeze", withExtension: "mov")!, title: "Squeeze", tag: 8)
        
    ]
}

private class InstructionsViewModel: ObservableObject {
    @Published var instruction: [Instruction] = Instruction.videos
}

struct TherapyInstructionsView: View {
    
    @StateObject fileprivate var instructionViewModel = InstructionsViewModel()
    
    let config = CKConfig.shared
    
    
    var body: some View {
        VStack {
            //Text("Therapy Exercises")
               // .font(.title2)
                //.padding(.top)
            TabView {
                ForEach(instructionViewModel.instruction) { instruction in
                    VStack {
                        Spacer()
                        Text("\(instruction.title)").bold()
                            //.padding()
                        VideoPlayer(player: AVPlayer(url: instruction.video))
                            .frame(width: 250, height: 202)
                            .padding(.bottom)
                        Spacer()
                        
                    }
                }
            }.tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .always)).accentColor(Color(config.readColor(query: "Primary Color")))
            
        }
    }
}

struct TherapyInstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        TherapyInstructionsView()
    }
}

