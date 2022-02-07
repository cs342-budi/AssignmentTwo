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
            Text("Contact My Care Team")
            Spacer()
            Text("›")
        }.frame(height: 60)
            .contentShape(Rectangle())
            .gesture(TapGesture().onEnded({
                self.showContacts.toggle()
            })).sheet(isPresented: $showContacts, onDismiss: {
                
            }, content: {
                CareTeamViewControllerRepresentable()
            })
        
    }
}

struct CareTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CareTeamView()
    }
}
