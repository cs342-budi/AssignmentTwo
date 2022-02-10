//
//  LiveTherapyView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct LiveTherapyView: View {
    var body: some View {
        // 1
        VStack{
            Text("My Live Therapy Tracker")
                .fontWeight(.heavy)
                .font(.title2)
                .foregroundColor(Color.black)
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
