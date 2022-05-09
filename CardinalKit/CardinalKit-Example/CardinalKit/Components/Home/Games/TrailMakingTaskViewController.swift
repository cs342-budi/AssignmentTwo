//
//  TrailMakingTaskViewController.swift
//  CardinalKit_Example
//
//  Created by Maria Shcherbakova on 5/1/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import ResearchKit

struct TrailMakingTaskViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ORKTaskViewController
    
    func makeCoordinator() -> ActiveTaskViewCoordinator {
        ActiveTaskViewCoordinator()
    }
    
    func updateUIViewController(_ taskViewController: ORKTaskViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> ORKTaskViewController {
        let trailMakingTask: ORKOrderedTask = {
            let intendedUseDescription = "Trail making task for BUDI"
            
            return ORKOrderedTask.trailmakingTask(withIdentifier: "TrailMakingTask", intendedUseDescription: intendedUseDescription, trailmakingInstruction: "Try connecting labelled circles in order.", trailType: ORKTrailMakingTypeIdentifier.A, options: ORKPredefinedTaskOption())
        }()
        
        let taskViewController = ORKTaskViewController(task: trailMakingTask, taskRun: nil)
        
        taskViewController.delegate = context.coordinator
        
        return taskViewController
    }
}

struct TrailMakingTaskViewController_Previews: PreviewProvider {
    static var previews: some View {
        TrailMakingTaskViewController()
    }
}

