//
//  TimeBlockView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/9/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct TimeBlock: View {
    var time: String
    var ampm: String
    
    var body: some View {
        Button(action: {
            print("Button tapped.")
        }) {
            HStack(alignment: .lastTextBaseline) {
            Text(time)
                .font(.title)
                .foregroundColor(Color.white)
            Text(ampm)
                .font(.headline)
                .foregroundColor(Color.white)
            }
            .padding(Metrics.PADDING_VERTICAL_MAIN*3.5)
//            .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
//            .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
            .background(Color.pink)
            .cornerRadius(10)
 
            
        }
    }
}

struct TimeBlock_Previews: PreviewProvider {
    static var previews: some View {
        TimeBlock(time:"11:00", ampm: "AM")
    }
}
