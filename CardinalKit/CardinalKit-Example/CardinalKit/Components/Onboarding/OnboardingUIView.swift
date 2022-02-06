//
//  OnboardingUIView.swift
//  CardinalKit_Example
//
//  Created by Varun Shenoy on 8/14/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import SwiftUI
import UIKit
import ResearchKit
import CardinalKit
import Firebase

struct OnboardingElement {
    let logo: String
    let title: String
    let description: String
}

struct OnboardingUIView: View {
    
    var onboardingElements: [OnboardingElement] = []
    let color: Color
    let config = CKPropertyReader(file: "CKConfiguration")
    @State var showingOnboard = false
    @State var showingLogin = false
    
    var onComplete: (() -> Void)? = nil
    
    init(onComplete: (() -> Void)? = nil) {
        let onboardingData = config.readAny(query: "Onboarding") as! [[String:String]]
        
        
        self.color = Color(config.readColor(query: "Primary Color"))
        self.onComplete = onComplete
        
        for data in onboardingData {
            self.onboardingElements.append(OnboardingElement(logo: data["Logo"]!, title: data["Title"]!, description: data["Description"]!))
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            Image("SBDLogoGrey")
                .resizable()
                .scaledToFit()
                .padding(.leading, Metrics.PADDING_HORIZONTAL_MAIN*5)
                .padding(.trailing, Metrics.PADDING_HORIZONTAL_MAIN*5)
            
            Spacer(minLength: 2)
            
            Image("budi-green")
                .resizable()
                .padding(.leading, Metrics.PADDING_HORIZONTAL_MAIN*3)
                .padding(.trailing, Metrics.PADDING_HORIZONTAL_MAIN*3)
                .scaledToFit()
            
            
//            Text(config.read(query: "Study Title"))
//                .foregroundColor(self.color)
//                .multilineTextAlignment(.center)
//                .font(.system(size: 35, weight: .bold, design: .default))
//                .padding(.leading, Metrics.PADDING_HORIZONTAL_MAIN)
//                .padding(.trailing, Metrics.PADDING_HORIZONTAL_MAIN)
            
//            Text(config.read(query: "Team Name"))
//                .padding(.leading, Metrics.PADDING_HORIZONTAL_MAIN)
//                .padding(.trailing, Metrics.PADDING_HORIZONTAL_MAIN)

            PageView(self.onboardingElements.map { InfoView(logo: $0.logo, title: $0.title, description: $0.description, color: self.color) })

            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    self.showingOnboard.toggle()
                }, label: {
                     Text("Join BUDI")
                        .padding(Metrics.PADDING_BUTTON_LABEL)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(self.color)
                        .cornerRadius(Metrics.RADIUS_CORNER_BUTTON)
                        .font(.system(size: 20, weight: .bold, design: .default))
                })
                .padding(.leading, Metrics.PADDING_HORIZONTAL_MAIN)
                .padding(.trailing, Metrics.PADDING_HORIZONTAL_MAIN)
                .sheet(isPresented: $showingOnboard, onDismiss: {
                    self.onComplete?()
                }, content: {
                    OnboardingViewController().ignoresSafeArea(edges: .all)
                })
        
                Spacer()
            }
            
            HStack {
                Spacer()
                Button(action: {
                    self.showingLogin.toggle()
                }, label: {
                     Text("I'm a Returning User")
                        .padding(Metrics.PADDING_BUTTON_LABEL)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(self.color)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .overlay(
                                    RoundedRectangle(cornerRadius: Metrics.RADIUS_CORNER_BUTTON)
                                        .stroke(self.color, lineWidth: 2)
                            )
                })
                .padding(.leading, Metrics.PADDING_HORIZONTAL_MAIN)
                .padding(.trailing, Metrics.PADDING_HORIZONTAL_MAIN)
                .sheet(isPresented: $showingLogin, onDismiss: {
                    self.onComplete?()
                }, content: {
                    LoginExistingUserViewController().ignoresSafeArea(edges: .all)
                })
        
                Spacer()
            }
            
            Spacer()
        }
    }
}

struct InfoView: View {
    let logo: String
    let title: String
    let description: String
    let color: Color
    var body: some View {
        VStack(spacing: 2) {
            Circle()
                .fill(.white)
                .frame(width: 100, height: 120, alignment: .center)
                .padding(6)
                .overlay(
//                    Text(logo)
//                        .foregroundColor(.white)
//                        .font(.system(size: 42, weight: .light, design: .default))
                    Image(logo)
                        .resizable()
                        .scaledToFit()
                )

            Text(title).font(.title)
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                .padding(.bottom)
        }
    }
}

struct OnboardingUIView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingUIView()
    }
}
