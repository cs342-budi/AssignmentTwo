//
//  TimeBlockView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/9/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import Foundation

struct TimeBlock: View {
    var time: Date
    
    var body: some View {
        Button(action: {
            print("Button tapped.")
        }) {
            HStack(alignment: .lastTextBaseline) {
                Text(TimeConverter.toStrTime(time: time))
                .font(.title)
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

class TimeConverter {
    static func toStrTime(time: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let strTime = dateFormatter.string(from: time)
        print(strTime)
        return strTime
    }
}

struct TimeBlock_Previews: PreviewProvider {
    static var previews: some View {
        TimeBlock(time: Date())
    }
}
