//
//  ProfileUIView.swift
//  CardinalKit_Example
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import SwiftUI

struct ProfileUIView: View {
    let color: Color
    let config = CKPropertyReader(file: "CKConfiguration")
    
    init(color: Color) {
        self.color = color
    }
    
    var body: some View {
       
        VStack {
            //Text("Profile").font(.system(size: 25, weight:.bold))
            
            
            List {
                //REMOVE PROFILE NAME / PICTURE FOR BETA 
//                Section {
//                    ProfilePictureView()
//                }
                
//                Section {
//                    HStack {
////                        ProfilePictureView()
//                        PatientIDView()
//                    }
//                }.listRowBackground(Color.white)
                
                Section {
                   
                    NavigationLink(destination: ScheduleView()) {
                        TherapySettingsView()
                    }.padding()
                    
                    NavigationLink(destination: SetGoals()) {
                        GoalsView()
                    }.padding()
                    
                    NavigationLink(destination: CareTeamViewControllerRepresentable()) {
                        CareTeamView()
                    }.padding()
                    
                }
                
           
                Section {
                    // ** HEALTH RECORDS UPLOAD DISABLED **
                    // SendRecordsView()

                    ChangePasscodeView()

                    HelpView(site: config.read(query: "Website"))
                }
                
                Section {
                    ReportView(color: self.color, email: config.read(query: "Email"))
                    SupportView(color: self.color, phone: config.read(query: "Phone"))

                    // ** CONSENT DOCUMENT DISABLED **
                    // DocumentView()
                }
                
                Section {
                    WithdrawView(color: self.color)
                }
                
                Section {
                    Text(config.read(query: "Copyright"))
                }
            }.listStyle(GroupedListStyle())
                .navigationBarTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

struct ProfileUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUIView(color: Color.red)
    }
}
