//
//  GoalsView.swift
//  CardinalKit_Example
//
//  Created by Beste Aydin on 3/1/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct GoalsView: View {
    @State var showSettings = false
    
    var body: some View {
        HStack {
            Image("target")
                .resizable()
                .frame(width: 60.0, height: 60.0)
                .padding(.trailing)
               
            Text("SET GOALS")
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
                SetGoals()
            }).padding()
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}
