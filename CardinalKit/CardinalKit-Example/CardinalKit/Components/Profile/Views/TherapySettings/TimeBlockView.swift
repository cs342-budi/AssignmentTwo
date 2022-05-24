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
    var day : String
    @State var showDeleteModal : Bool = false
    @Binding var updater : Bool
    
    var body: some View {
        Button(action: {
            showDeleteModal.toggle()
        }, label: {
            HStack(alignment: .lastTextBaseline) {
                Text(TimeConverter.toStrTime(time: time))
                .font(.title)
                .foregroundColor(Color.white)
            }
            .padding(Metrics.PADDING_VERTICAL_MAIN*3.5)
            .background(Color("Accent"))
            .cornerRadius(10)
        }).sheet(isPresented: $showDeleteModal) {
            DeleteModalView(isPresented: $showDeleteModal, day: day, time: time, updater: $updater)
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


