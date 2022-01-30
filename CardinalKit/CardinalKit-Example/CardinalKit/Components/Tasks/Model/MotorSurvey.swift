//
//  Question 7- Assistive tech survey.swift
//  CardinalKit_Example
//
//  Created by Yoon-Ju Kim on 1/27/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//
import ResearchKit

static let moodSurvey: ORKOrderedTask = {
// answer value format
            let sampleArray = [
             ORKTextChoice(text: "January", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "February", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "March", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
            ]
            let answerValueFormat = ORKValuePickerAnswerFormat(textChoices: sampleArray)
            let answerValueQuestionStep = ORKQuestionStep(identifier: "AnswerValueQuestion", title: nil, question: "Select a month", answer: answerValueFormat)
            
            steps += [answerValueQuestionStep]
import Foundation
}
} 
