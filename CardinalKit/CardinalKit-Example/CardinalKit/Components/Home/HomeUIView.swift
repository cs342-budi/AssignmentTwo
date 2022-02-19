//
//  HomeUIView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/6/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import Charts

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
                        Button (action:{}) {
                            Text("START THERAPY")
                                .fontWeight(.heavy)
                                .font(.title2)
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
                        .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
                        .background(self.color)
                        .cornerRadius(10)
                        
                        NavigationLink(destination: LiveTherapyView(entries: [
                            //x - position of a bar, y - height of a bar
                            ChartDataEntry(x: 1, y: 1),
                            ChartDataEntry(x: 2, y: 2),
                            ChartDataEntry(x: 3, y: 3),
                            ChartDataEntry(x: 4, y: 4),
                            ChartDataEntry(x: 5, y: 5)
                        ]),
                                   label: {}).opacity(0)
                    }.padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*0.5)
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*0.5)
                    
                  
                  

                    ZStack {
                        Button (action:{}) {
                            Text("PLAY GAMES")
                                .fontWeight(.heavy)
                                .font(.title2)
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
                        .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        
                        
                        NavigationLink(destination: GamesMainView(),
                                   label: {}).opacity(0)
                    }.padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*0.5)
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*0.5)
                       
                 
                    
                    ZStack {
                        Button (action:{}) {
                            Text("VIEW PROGRESS")
                                .fontWeight(.heavy)
                                .font(.title2)
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
                        .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
                        .background(self.accent)
                        .cornerRadius(10)
   
                        NavigationLink(destination: ProgressUIView(entries: [
                            //x - position of a bar, y - height of a bar
                            BarChartDataEntry(x: 1, y: 1),
                            BarChartDataEntry(x: 2, y: 2),
                            BarChartDataEntry(x: 3, y: 3),
                            BarChartDataEntry(x: 4, y: 4),
                            BarChartDataEntry(x: 5, y: 5)
                        ]),
                                   label: {}).opacity(0)
                    }.padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*0.5)
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*0.5)
                    
                   
                        
                    
                    ZStack {
                        Button (action:{}) {
                            Text("MY PROFILE")
                                .fontWeight(.heavy)
                                .font(.title2)
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
                        .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
                        .background(Color.gray)
                        .cornerRadius(10)
                        
                        
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
