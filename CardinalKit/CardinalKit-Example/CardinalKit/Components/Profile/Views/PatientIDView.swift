//
//  PatientIDView.swift
//  CardinalKit_Example
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import SwiftUI

struct PatientIDView: View {
    var userID = ""
    var firstName = ""
    var lastName = ""
    var birthday = ""
    
    init() {
        if let currentUser = CKStudyUser.shared.currentUser {
            self.userID = currentUser.uid
        }
        let defaults = UserDefaults.standard
        if let first_name = defaults.string(forKey: DefaultsKeys.FirstName) {
            self.firstName = first_name
        }
        if let last_name = defaults.string(forKey: DefaultsKeys.LastName) {
            self.lastName = last_name
        }
        if let birthday = defaults.string(forKey: DefaultsKeys.Birthday) {
            self.birthday = birthday
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(self.firstName).font(.system(.largeTitle)).foregroundColor(.green)
                Spacer()
            }.padding([.top, .bottom])
//            HStack {
//                Text("Total Therapy (min):")
//                Text("65")
//                    .foregroundColor(Color.green)
//                    .fontWeight(.heavy)
//                    .font(.system(size: 24))
//            }.padding(.bottom)
//            HStack {
//                Text("Badge 1")
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(30)
//                    .foregroundColor(Color.green)
//                Text("Badge 2")
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(30)
//                    .foregroundColor(Color.green)
//                Text("Badge 3")
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(30)
//                    .foregroundColor(Color.green)
//            }.padding(.bottom)
        }
    }
}

struct PatientIDView_Previews: PreviewProvider {
    static var previews: some View {
        PatientIDView()
    }
}
