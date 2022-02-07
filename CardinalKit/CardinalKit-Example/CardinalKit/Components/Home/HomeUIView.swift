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
            
            NavigationView {
                List {
                    ZStack {
                        Text("START THERAPY")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
                            .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
                            .background(self.color)
                            .foregroundColor(Color.white)
                        
                        NavigationLink(destination: LiveTherapyView(),
                                   label: {}).opacity(0)
                    }.padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*0.5)
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*0.5)
                    
                  
                  

                    ZStack {
                        Text("PLAY GAMES")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
                            .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
                            .background(Color.yellow)
                            .foregroundColor(Color.white)
                        NavigationLink(destination: GamesMainView(),
                                   label: {}).opacity(0)
                    }.padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*0.5)
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*0.5)
                       
                 
                    
                    ZStack {
                        Text("VIEW PROGRESS")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
                            .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
                            .background(self.accent)
                            .foregroundColor(Color.white)
   
                        NavigationLink(destination: ProgressUIView(),
                                   label: {}).opacity(0)
                    }.padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*0.5)
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*0.5)
                    
                   
                        
                    
                    ZStack {
                        Text("MY PROFILE")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
                            .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
                            .background(Color.gray)
                            .foregroundColor(Color.white)
                        
                        NavigationLink(destination: ProfileUIView(color: self.color),
                                   label: {}).opacity(0)
                    }.padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*0.5)
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*0.5)
                    
                    
               
                }.listStyle(PlainListStyle())
                    .padding(.leading)
                    .padding(.trailing)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)

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
