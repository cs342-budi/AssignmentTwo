//
//  SurveyCompletionController.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 5/23/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI


class SurveyCompletionController: ObservableObject {
    static let shared = SurveyCompletionController()
    @Published var completed : Bool
    let userDefaults = UserDefaults.standard 
    
    init () {
        if let storedCompletion = UserDefaults.standard.object(forKey: Constants.surveyDidComplete) as? Bool {
            completed = storedCompletion
        } else {
            completed = false
        }
    }
    
    func completeSurvey () {
        completed = true
        
        //store in user defaults
        userDefaults.set(completed, forKey: Constants.surveyDidComplete)
    }
    
    func surveyIncomplete () {
        completed = false
    }
}
