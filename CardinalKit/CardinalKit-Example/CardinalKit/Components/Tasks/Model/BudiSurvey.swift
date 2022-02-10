//
//  BudiSurvey.swift
//  CardinalKit_Example
//
//  Created by Lina Fang on 23.01.22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import ResearchKit
import Foundation
import UIKit

struct BudiSurvey {
    
    static let budiSurvey: ORKOrderedTask = {
        var steps = [ORKStep]()
        
        // Q1
        let textChoiceQ1aAnswerFormat = ORKTextAnswerFormat.textAnswerFormat()
        let textStepQ1a = ORKQuestionStep(identifier: "Q1aQuestionStep", title: "Question #1", question: "What is your first name?", answer: textChoiceQ1aAnswerFormat)
        textStepQ1a.image = UIImage(named: "Q1a")
        
        steps += [textStepQ1a]
        
        let textChoiceQ1bAnswerFormat = ORKTextAnswerFormat.textAnswerFormat()
        let textStepQ1b = ORKQuestionStep(identifier: "Q1bQuestionStep", title: "Question #1", question: "What is your last name?", answer: textChoiceQ1bAnswerFormat)
        textStepQ1b.image = UIImage(named: "Q1b")
        
        steps += [textStepQ1b]
        
        // Q2
        let textChoiceQ2AnswerFormat = ORKDateAnswerFormat.dateAnswerFormat()
        let textStepQ2 = ORKQuestionStep(identifier: "Q2QuestionStep", title: "Question #2", question: "Please enter your birthday.", answer: textChoiceQ2AnswerFormat)
        textStepQ2.image = UIImage(named: "Q2")
        
        steps += [textStepQ2]
        
        
        // Q3
        let textChoicesQ3 = [
        ORKTextChoice(text: "Before preschool", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Preschool", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Pre-k", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Kindergarten", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Grades 1-12", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Undergraduate", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Graduate", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Other", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let textChoiceQ3AnswerFormat = ORKAnswerFormat.valuePickerAnswerFormat(with: textChoicesQ3)
        let textStepQ3 = ORKQuestionStep(identifier: "Q3QuestionStep", title: "Question #3", question: "What grade are you in?", answer: textChoiceQ3AnswerFormat)
        textStepQ3.image = UIImage(named: "Q3")
        
        steps += [textStepQ3]
        
        // Q4
        let textChoicesQ4 = [
        ORKTextChoice(text: "Yes", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "No", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "I don't know", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let textChoiceQ4AnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoicesQ4)
        let textStepQ4 = ORKQuestionStep(identifier: "Q4QuestionStep", title: "Question #4", question: "Do you have a diagnosis of cerebral palsy?", answer: textChoiceQ4AnswerFormat)
        textStepQ4.image = UIImage(named: "Q4")
        
        steps += [textStepQ4]
        
        // Q5
        let textChoicesQ5 = [
        ORKTextChoice(text: "Spastic", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Dyskinetic", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Ataxic", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "I don't know", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let textChoiceQ5AnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: textChoicesQ5)
        let textStepQ5 = ORKQuestionStep(identifier: "Q5QuestionStep", title: "Question #5", question: "What type(s) of cerebral palsy do you have? (check all that apply)", answer: textChoiceQ5AnswerFormat)
        textStepQ5.image = UIImage(named: "Q5")
        
        steps += [textStepQ5]
        
        // Q6
        let textChoicesQ6 = [
        ORKTextChoice(text: "Right side of my body (hemiplegia)", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Left side of my body (hemiplegia)", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Both of my legs (paraplegia)", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Both of my arms & legs (quadriplegia)", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let textChoiceQ6AnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: textChoicesQ6)
        let textStepQ6 = ORKQuestionStep(identifier: "Q6QuestionStep", title: "Question #6", question: "What part(s) of your body are most affected?", answer: textChoiceQ6AnswerFormat)
        textStepQ6.image = UIImage(named: "Q6")
        
        steps += [textStepQ6]
        
        // Q7
        let textChoicesQ7 = [
        ORKTextChoice(text: "I", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "II", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "III", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "IV", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "V", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "I don't know", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let textChoiceQ7AnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: textChoicesQ7)
        let textStepQ7 = ORKQuestionStep(identifier: "Q7QuestionStep", title: "Question #7", question: "What is your motor function according to the Gross Motor Function Classification System?", answer: textChoiceQ7AnswerFormat)
        textStepQ7.image = UIImage(named: "Q7")
        
        steps += [textStepQ7]
        
        // Q8
        let textChoicesQ8 = [
        ORKTextChoice(text: "Wheelchair", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Walker", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Orthotics", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Arm crutches", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoiceOther(text: "Other", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let textChoiceQ8AnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: textChoicesQ8)
        let textStepQ8 = ORKQuestionStep(identifier: "Q8QuestionStep", title: "Question #8", question: "Do you use any assistive technology? (check all that apply)", answer: textChoiceQ8AnswerFormat)
        textStepQ8.image = UIImage(named: "Q8")
        
        steps += [textStepQ8]
        
        // Q9
        let textChoicesQ9 = [
        ORKTextChoice(text: "Walking", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Taking the stairs", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Talking", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Eating & Swallowing", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Taking a shower", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Going to the bathroom", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Brushing my teeth", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Texting & Using my phone", value: 7 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Sleeping", value: 8 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoiceOther(text: "Other", value: 9 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let textChoiceQ9AnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: textChoicesQ9)
        let textStepQ9 = ORKQuestionStep(identifier: "Q9QuestionStep", title: "Question #9", question: "What sorts of activities to you find difficult? (check all that apply)", answer: textChoiceQ9AnswerFormat)
        textStepQ9.image = UIImage(named: "Q9")
        
        steps += [textStepQ9]
        
        // Summary

        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Thank you!"
        summaryStep.text = "We appreciate your time."

        steps += [summaryStep]
        
//        return steps
        return ORKOrderedTask(identifier: "BudiSurvey", steps: steps)
    
    }()
    
    
}
