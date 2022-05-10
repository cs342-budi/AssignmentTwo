//
//  TherapySettingsView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct TherapySettingsView: View {
    @State var showSettings = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        HStack {
            Image("therapy-settings-white")
                .padding(.trailing)
               
            Text("MY SETTINGS")
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
            .gesture(TapGesture().onEnded({
                self.showSettings.toggle()
            })).sheet(isPresented: $showSettings, onDismiss: {
            }, content: {
                ScheduleView().environment(\.managedObjectContext, self.managedObjectContext)
            }).padding()
        
    }
}

struct TherapySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TherapySettingsView()
    }
}
