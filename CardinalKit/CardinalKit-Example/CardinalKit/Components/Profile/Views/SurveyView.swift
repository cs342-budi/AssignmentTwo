//
//  SurveyView.swift
//  CardinalKit_Example
//
//  Created by billzhu on 2/10/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct SurveyView: View {
    @State var showSettings = false
    
    var body: some View {
        HStack {
            Spacer()
            Text("SURVEY")
                .fontWeight(.bold)
                .font(.title2)
                .foregroundColor(.white)
                .frame(alignment: .center)
            Spacer()
        }.frame(height: 60, alignment: .center)
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
            .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
            .background(Color.gray)
            .cornerRadius(10)
            .gesture(TapGesture().onEnded({
                self.showSettings.toggle()
            }))
            .sheet(isPresented: $showSettings, onDismiss: {
            }, content: {
                CKTaskViewController(tasks: BudiSurvey.budiSurvey)
            }).padding()
        
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView()
    }
}
