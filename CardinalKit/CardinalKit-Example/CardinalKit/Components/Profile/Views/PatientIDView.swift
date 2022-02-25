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
                Text("First Name: " + self.firstName).font(.system(.body)).foregroundColor(Color(.greyText()))
                Spacer()
            }
            HStack {
                Text("Last Name: " + self.lastName).font(.system(.body)).foregroundColor(Color(.greyText()))
                Spacer()
            }
            HStack {
                Text("Birthday: " + self.birthday).font(.system(.body)).foregroundColor(Color(.greyText()))
                Spacer()
            }
        }.frame(height: 100)
    }
}

struct PatientIDView_Previews: PreviewProvider {
    static var previews: some View {
        PatientIDView()
    }
}
