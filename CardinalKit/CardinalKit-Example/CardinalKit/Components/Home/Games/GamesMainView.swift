//
//  GamesMainView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct GamesMainView: View {
    @State private var showingTapGame = false
    
    var body: some View {
        VStack {
            HStack {
                Button (action:{
                    showingTapGame.toggle()
                }) {
                    Text("QUICK TAP")
                        .fontWeight(.heavy)
                        .font(.title)
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
                .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
                .background(Color.yellow)
                .cornerRadius(10)
                .sheet(isPresented: $showingTapGame) {
                    ActiveTaskViewController()
                }
            }.padding()
            Spacer()
        }
    }
    
}

struct GamesMainView_Previews: PreviewProvider {
    static var previews: some View {
        GamesMainView()
    }
}
