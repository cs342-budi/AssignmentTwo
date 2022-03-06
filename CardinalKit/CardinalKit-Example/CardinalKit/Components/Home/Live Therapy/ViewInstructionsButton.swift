//
//  ViewInstructionsButton.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 3/5/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct ViewInstructionsButton: View {
    @State private var showingTherapyVideos = false
    
    let color: Color
    let config = CKPropertyReader(file: "CKConfiguration")
    
    var onComplete: (() -> Void)? = nil
    
    init(onComplete: (() -> Void)? = nil) {
        self.color = Color(config.readColor(query: "Primary Color"))
    }
    
    var body: some View {
        Button(action: {
            self.showingTherapyVideos.toggle()
        }) {
            HStack(alignment: .center) {
                Text("VIEW EXERCISES")
                    .fontWeight(.heavy)
                    .font(.title2)
                    .foregroundColor(Color.white)
               
            }
            .frame(maxWidth: .infinity)
            .padding(Metrics.PADDING_VERTICAL_MAIN*3.2)
            .background(self.color)
            .cornerRadius(10)
            .padding(.leading)
            .padding(.trailing)
 
            
        }.sheet(isPresented: $showingTherapyVideos) {
            TherapyInstructionsView()
    }
    }
}

struct ViewInstructionsButton_Previews: PreviewProvider {
    static var previews: some View {
        ViewInstructionsButton()
    }
}
