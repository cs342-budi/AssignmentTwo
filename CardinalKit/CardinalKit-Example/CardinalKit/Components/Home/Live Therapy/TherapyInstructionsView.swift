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
    var reps: String
}

extension Instruction {
    static let videos = [
        Instruction(video: Bundle.main.url(forResource: "armAcrossBody", withExtension: "mov")!, title: "Arm Across Body", tag: 0, reps: "2 x 15"),
        Instruction(video: Bundle.main.url(forResource: "armOutCropped", withExtension: "mov")!, title: "Arm Out", tag: 1, reps: "3 x 10" ),
        Instruction(video: Bundle.main.url(forResource: "armUpCropped", withExtension: "mov")!, title: "Arm Up", tag: 2, reps: "2 x 20"),
        Instruction(video: Bundle.main.url(forResource: "forwardArmCircles", withExtension: "mov")!, title: "Forward Arm Circles", tag: 3, reps: "3 x 10"),
        Instruction(video: Bundle.main.url(forResource: "backCircles", withExtension: "mov")!, title: "Back Circles", tag: 4, reps: "3 x 10"),
        Instruction(video: Bundle.main.url(forResource: "upDownmov", withExtension: "mov")!, title: "Up Down", tag: 5, reps: "2 x 15"),
        Instruction(video: Bundle.main.url(forResource: "pushUpWallmov", withExtension: "mov")!, title: "Push Up Wall", tag: 6, reps: "2 x 15"),
        Instruction(video: Bundle.main.url(forResource: "fingers", withExtension: "mov")!, title: "Fingers", tag: 7, reps: "2 x 15"),
        Instruction(video: Bundle.main.url(forResource: "squeeze", withExtension: "mov")!, title: "Squeeze", tag: 8, reps: "2 x 15")
        
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
                        VideoPlayer(player: AVPlayer(url: instruction.video))
                            .frame(width: UIScreen.main.bounds.size.width, height: 200)
                            .padding(.bottom, 20)
                        HStack{
                            Text("\(instruction.title)")
                                .fontWeight(.semibold)
                                .font(.system(size: 17))
                            Spacer()
                            Text("\(instruction.reps)" + " reps")
                                .fontWeight(.light)
                                .font(.system(size: 13))
                        }.padding([.leading, .trailing])
                          
                    }
                }
            }.tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .interactive)).accentColor(Color(config.readColor(query: "Primary Color")))
            
            Button (action:{
               print("tapped log exercise")
                
            }) {
                Text("Log Exercise")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(Metrics.PADDING_VERTICAL_MAIN*1.75)
            .background(Color.black)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct TherapyInstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        TherapyInstructionsView()
    }
}

