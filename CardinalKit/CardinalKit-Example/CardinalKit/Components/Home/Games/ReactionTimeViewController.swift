//
//  ReacationTimeViewController.swift
//  CardinalKit_Example
//
//  Created by Maria Shcherbakova on 5/1/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import ResearchKit

struct ReactionTimeViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ORKTaskViewController
    
    func makeCoordinator() -> ActiveTaskViewCoordinator {
        ActiveTaskViewCoordinator()
    }
    
    func updateUIViewController(_ taskViewController: ORKTaskViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> ORKTaskViewController {
        let reactionTime: ORKOrderedTask = {
            let intendedUseDescription = "Reaction time active task for BUDI"
            
            return ORKOrderedTask.reactionTime(withIdentifier: "ReactionTime", intendedUseDescription: intendedUseDescription, maximumStimulusInterval: 4, minimumStimulusInterval: 2, thresholdAcceleration: 0.5, numberOfAttempts: 5, timeout: 4, successSound: 0, timeoutSound: 0, failureSound: 0, options: ORKPredefinedTaskOption())
        }()
        
        let taskViewController = ORKTaskViewController(task: reactionTime, taskRun: nil)
        
        taskViewController.delegate = context.coordinator
        
        return taskViewController
    }
}

struct ReactionTimeViewController_Previews: PreviewProvider {
    static var previews: some View {
        ReactionTimeViewController()
    }
}
