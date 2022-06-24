//
//  TherapySettingsView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct TherapySettingsView: View {
    @State var showSettings = true
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
       
        HStack {
            Image("therapy-settings-white")
                .padding(.trailing)
               
            Text("MY SCHEDULE")
                .fontWeight(.bold)
                .font(.title2)
                .foregroundColor(.white)
            Spacer()
            
        }.frame(height: 60)
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
            .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
            .background(Color.gray)
            .cornerRadius(10)

 
        
    }
}

struct TherapySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TherapySettingsView()
    }
}
