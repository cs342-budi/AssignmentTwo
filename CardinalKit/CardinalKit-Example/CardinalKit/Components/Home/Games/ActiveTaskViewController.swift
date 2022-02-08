//
//  ActiveTaskViewController.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import ResearchKit

struct ActiveTaskViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ORKTaskViewController
    
    func makeCoordinator() -> ActiveTaskViewCoordinator {
        ActiveTaskViewCoordinator()
    }
    
    func updateUIViewController(_ taskViewController: ORKTaskViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> ORKTaskViewController {
        let tappingTask: ORKOrderedTask = {
            return ORKOrderedTask.twoFingerTappingIntervalTask(withIdentifier: "tappingTask", intendedUseDescription: "Finger Tapping Mobility Exercise", duration: 15, handOptions: .both, options:ORKPredefinedTaskOption())
        }()
        
        let taskViewController = ORKTaskViewController(task: tappingTask, taskRun: nil)
        
        taskViewController.delegate = context.coordinator
        
        return taskViewController
    }
}

struct ActiveTaskViewController_Previews: PreviewProvider {
    static var previews: some View {
        ActiveTaskViewController()
    }
}
