//
//  LoginViewController.swift
//  BUDI
//
//  Created by Varun Shenoy on 3/2/21. 
//  Copyright © 2022 BUDI. All rights reserved.
//

import SwiftUI
import UIKit
import ResearchKit
import CardinalKit
import Firebase

struct LoginExistingUserViewController: UIViewControllerRepresentable {
    
    func makeCoordinator() -> OnboardingViewCoordinator {
        OnboardingViewCoordinator()
    }

    typealias UIViewControllerType = ORKTaskViewController
    
    func updateUIViewController(_ taskViewController: ORKTaskViewController, context: Context) {}
    func makeUIViewController(context: Context) -> ORKTaskViewController {
        let config = CKPropertyReader(file: "CKConfiguration")
        var loginSteps: [ORKStep] = []

        let signInButtons = CKMultipleSignInStep(identifier: "SignInButtons")

        let loginUserPassword = ORKLoginStep(identifier: "LoginUserPassword", title: "Login", text: "Log into BUDI.", loginViewControllerClass: LoginViewController.self)

        let healthDataStep = CKHealthDataStep(identifier: "HealthData")

        // ** HEALTH RECORDS IS DISABLED IN THIS PROJECT **
        // let healthRecordsStep = CKHealthRecordsStep(identifier: "HealthRecords")
        
        // ** CONSENT DOCUMENT IS DISABLED IN THIS PROJECT **
        // let consentDocument = ConsentDocument()
        // let signature = consentDocument.signatures?.first
        // let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
        // reviewConsentStep.text = config.read(query: "Review Consent Step Text")
        // reviewConsentStep.reasonForConsent = config.read(query: "Reason for Consent Text")
        // let consentReview = CKReviewConsentDocument(identifier: "ConsentReview")
        
        // set passcode
        let passcodeStep = ORKPasscodeStep(identifier: "Passcode")
        let type = config.read(query: "Passcode Type")
        if type == "6" {
            passcodeStep.passcodeType = .type6Digit
        } else {
            passcodeStep.passcodeType = .type4Digit
        }
        passcodeStep.text = config.read(query: "Passcode Text")

        // loginSteps += [consentReview, reviewConsentStep, healthDataStep, healthRecordsStep, passcodeStep]
        loginSteps += [signInButtons, loginUserPassword, healthDataStep, passcodeStep]


        // This navigation rule checks if the user is signing in with a federated provider (Google, Apple, etc)
        // or email/password. If the latter, it redirects the user to the email/password sign in screen.
        // otherwise, it sends them to the health data step after signing in.
        // If consent is re-enabled in this project, it will need to be restored to the original rule below:
        //
        // let navigableTask = ORKNavigableOrderedTask(identifier: "StudyLoginTask", steps: loginSteps)
        // let resultSelector = ORKResultSelector(resultIdentifier: "SignInButtons")
        // let booleanAnswerType = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: true)
        // let predicateRule = ORKPredicateStepNavigationRule(resultPredicates: [booleanAnswerType],
        //                                                   destinationStepIdentifiers: ["LoginUserPassword"],
        //                                                   defaultStepIdentifier: "ConsentReview",
        //                                                   validateArrays: true)
        // navigableTask.setNavigationRule(predicateRule, forTriggerStepIdentifier: "SignInButtons")

        let navigableTask = ORKNavigableOrderedTask(identifier: "StudyLoginTask", steps: loginSteps)

        let resultSelector = ORKResultSelector(resultIdentifier: "SignInButtons")
        let booleanAnswerType = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: true)
        let predicateRule = ORKPredicateStepNavigationRule(resultPredicates: [booleanAnswerType],
                                                           destinationStepIdentifiers: ["LoginUserPassword"],
                                                           defaultStepIdentifier: "HealthData",
                                                           validateArrays: true)
        navigableTask.setNavigationRule(predicateRule, forTriggerStepIdentifier: "SignInButtons")

        // ** CONSENT NAVIGATION RULE DISABLED **
        // This rule checks if the user has a consent document in cloud storage, if not, asks them to sign
        // a consent document.
        //
        // let resultConsent = ORKResultSelector(resultIdentifier: "ConsentReview")
        // let booleanAnswerConsent = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultConsent, expectedAnswer: true)
        // let predicateRuleConsent = ORKPredicateStepNavigationRule(resultPredicates: [booleanAnswerConsent],
        //                                                  destinationStepIdentifiers: ["HealthKit"],
        //                                                  defaultStepIdentifier: "ConsentReviewStep",
        //                                                  validateArrays: true)
        // navigableTask.setNavigationRule(predicateRuleConsent, forTriggerStepIdentifier: "ConsentReview")

        
        // wrap that task on a view controller
        let taskViewController = ORKTaskViewController(task: navigableTask, taskRun: nil)
        taskViewController.delegate = context.coordinator // enables `ORKTaskViewControllerDelegate` below
        
        // & present the VC!
        return taskViewController
    }
    
}

