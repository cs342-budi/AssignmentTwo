//
//  HomeUIView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/6/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct HomeUIView: View {
    let color: Color
    let config = CKPropertyReader(file: "CKConfiguration")
    let accent: Color
    
    var onComplete: (() -> Void)? = nil
    
    init(onComplete: (() -> Void)? = nil) {
        self.color = Color(config.readColor(query: "Primary Color"))
        self.accent = Color(config.readColor(query: "Accent Color"))
        
    }

    
    
    
    var body: some View {
        VStack {
            HStack {
                
                Image("budi-green")
                    .resizable()
                    .frame(width: 160, height: 40)
                    .scaledToFit()
                    .padding(.bottom)
                    .padding(.leading)
                Spacer()
                Image("budi-art")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(.bottom)
                    .padding(.trailing)
                
                
            }
            
            
            Button(action:{}) {
                Text("START A WORKOUT")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.top, Metrics.PADDING_HORIZONTAL_MAIN*2)
                    .padding(.bottom, Metrics.PADDING_HORIZONTAL_MAIN*2)
                    .background(self.color)
                    .foregroundColor(Color.white)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, Metrics.PADDING_HORIZONTAL_MAIN*1.5)
            }
            
            Button(action:{}) {
                Text("PLAY GAMES")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.top, Metrics.PADDING_HORIZONTAL_MAIN*2)
                    .padding(.bottom, Metrics.PADDING_HORIZONTAL_MAIN*2)
                    .background(Color.yellow)
                    .foregroundColor(Color.white)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, Metrics.PADDING_HORIZONTAL_MAIN*1.5)
            }
            
            Button(action:{}) {
                Text("VIEW PROGRESS")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.top, Metrics.PADDING_HORIZONTAL_MAIN*2)
                    .padding(.bottom, Metrics.PADDING_HORIZONTAL_MAIN*2)
                    .background(self.accent)
                    .foregroundColor(Color.white)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, Metrics.PADDING_HORIZONTAL_MAIN*1.5)
            }

            
            
            Spacer()
           
            
        }.padding(.top)
    }
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeUIView()
    }
}
