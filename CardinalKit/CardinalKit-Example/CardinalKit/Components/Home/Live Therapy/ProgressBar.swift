//
//  ProgressBar.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 6/6/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.1)
                    .foregroundColor(Color.black)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color("Points"))
                    .animation(.linear)
            }.cornerRadius(3.0)
        }
    }
}

//struct ContentView: View {
//    @State var progressValue: Float = 0.0
//    
//    var body: some View {
//        VStack {
//            ProgressBar(value: $progressValue).frame(height: 20)
//            
//            Button(action: {
//                self.startProgressBar()
//            }) {
//                Text("Start Progress")
//            }.padding()
//            
//            Button(action: {
//                self.resetProgressBar()
//            }) {
//                Text("Reset")
//            }
//            
//            Spacer()
//        }.padding()
//    }
//    
//    func startProgressBar() {
//        for _ in 0...80 {
//            self.progressValue += 0.015
//        }
//    }
//    
//    func resetProgressBar() {
//        self.progressValue = 0.0
//    }
//}
