//
//  MainUIView.swift
//  CardinalKit_Example
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import SwiftUI

struct MainUIView: View {
    
    let color: Color
    let config = CKConfig.shared
    
    @State var useCareKit = false
    @State var carekitLoaded = false
    @StateObject var surveyController = SurveyCompletionController.shared
    @State var surveyCompleted = false

    
    init() {
        self.color = Color(config.readColor(query: "Primary Color"))
    }
    
    var body: some View {
        if surveyController.completed  {
            HomeUIView()
            .accentColor(self.color)
            .onAppear(perform: {
                self.useCareKit = config.readBool(query: "Use CareKit")
                
                let lastUpdateDate:Date? = UserDefaults.standard.object(forKey: Constants.prefCareKitCoreDataInitDate) as? Date
                CKCareKitManager.shared.coreDataStore.populateSampleData(lastUpdateDate:lastUpdateDate){() in
                    self.carekitLoaded = true
                }
                
            })
        } else {
            CKTaskViewController(tasks: BudiSurvey.budiSurvey)
        }
    }
}

struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
    }
}
