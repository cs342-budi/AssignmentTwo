//
//  MoodSurvey.swift
//  CardinalKit_Example
//
//  Created by Lina Fang on 23.01.22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import ResearchKit

struct MoodSurvey {
    
    static let moodSurvey: ORKOrderedTask = {
        var steps = [ORKStep]()
        
        //How are you feeling today?
        let moodSurveyAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 5, minimumValue: 1, defaultValue: 3, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Poor")
        let moodSurveyQuestionStep = ORKQuestionStep(identifier: "MoodSurveyQuestionStep", title: "Question #1", question: "How are you feeling today?", answer: moodSurveyAnswerFormat)
        
        steps += [moodSurveyQuestionStep]
        
        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Thank you!"
        summaryStep.text = "We appreciate your time."
        
        steps += [summaryStep]
        
        return ORKOrderedTask(identifier: "MoodSurvey", steps: steps)
    
    }()
}
