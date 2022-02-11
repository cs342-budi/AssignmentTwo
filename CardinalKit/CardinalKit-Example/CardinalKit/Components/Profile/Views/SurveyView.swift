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
            Text("SURVEY")
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
                TasksUIView(color: Color.black).tabItem{
                    Image("tab_tasks").renderingMode(.template)
                    Text("Tasks")
                }
            }).padding()
        
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView()
    }
}
