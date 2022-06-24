//
//  CareTeamView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/6/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct CareTeamView: View {
    @State var showContacts = false
    
    var body: some View {
   
        HStack {
            Image("provider-icon-white").padding(.trailing)
            
            Text("MY PROVIDERS")
                .fontWeight(.bold)
                .font(.title2)
                .foregroundColor(.white)
            Spacer()
            
        }.frame(height: 60)
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2)
            .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2)
            .background(Color.gray)
            .cornerRadius(10)
//            .gesture(TapGesture().onEnded({
//                self.showContacts.toggle()
//            })).sheet(isPresented: $showContacts, onDismiss: {
//
//            }, content: {
//                CareTeamViewControllerRepresentable()
//            }).padding()
        
    }
}

struct CareTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CareTeamView()
    }
}
