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
    
    let watchViewModel = WatchViewModel()
    
    let color: Color
    let config = CKPropertyReader(file: "CKConfiguration")
    let accent: Color
    
    var onComplete: (() -> Void)? = nil
    
    init(onComplete: (() -> Void)? = nil) {
        self.color = Color(config.readColor(query: "Primary Color"))
        self.accent = Color(config.readColor(query: "Accent Color"))
        
    }
    
    @State public var liveTherapyView = false

    
    var body: some View {
        VStack {
            
            NavigationView {
                VStack{
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
                List {
                    ZStack {
                        Button (action:{
                            // MARK: TAYLOR
                            // check if the watch is reachable
                            if self.watchViewModel.session.isReachable {
                                // send a message to the watch to start the therapy session
                                self.watchViewModel.session.sendMessage(["action": "THERAPY_START"], replyHandler: nil,         errorHandler: { (err) in
                                    print(err.localizedDescription)
                                })
                            } else {
                                print ("cannot reach watch")
                            }
                            
                            liveTherapyView.toggle()
                        
                            
                        }) {
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
                        
                    }.padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*0.5)
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*0.5)
                        .fullScreenCover(isPresented: $liveTherapyView) {
                            LiveTherapyView(watchViewModel: watchViewModel, isLiveTherapyPresented: $liveTherapyView)
                        }
                        
                    
                  
                  

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
   
                        NavigationLink(destination: ProgressUIView(),
                                   label: {}).opacity(0)
                    }.padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*0.5)
                        .padding(.top, Metrics.PADDING_VERTICAL_MAIN*0.5)
                    
                   
                        
                    
                    ZStack {
                        Button (action:{}) {
                            Text("MY SETTINGS")
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
           
            }
        
        }.padding(.top)
        .onAppear {
            switch watchViewModel.timerMessage {
            case "END":
                liveTherapyView = false
                print("End workout")
            case "START":
                liveTherapyView = true
            default:
                print("default_live_therapy")
            }
        }
    
    }
    
//    func startTherapy() -> Bool {
//
//        var startTherapy = false
//
//
//
//        return startTherapy
//    }
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeUIView()
    }
}
