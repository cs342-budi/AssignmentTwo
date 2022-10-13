//
//  NineHoleViewController.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import ResearchKit

struct NineHoleViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ORKTaskViewController
    
    func makeCoordinator() -> ActiveTaskViewCoordinator {
        ActiveTaskViewCoordinator()
    }
    
    func updateUIViewController(_ taskViewController: ORKTaskViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> ORKTaskViewController {
        let nineHoleTask: ORKOrderedTask = {
            return ORKOrderedTask.holePegTest(withIdentifier: "nineHoleTask", intendedUseDescription: "Hand Dexterity Exercise", dominantHand: .right, numberOfPegs: 5, threshold: 0.1, rotated: false, timeLimit: 30, options: .excludeAudio)
        }()
        
        let taskViewController = ORKTaskViewController(task: nineHoleTask, taskRun: nil)
        
        taskViewController.delegate = context.coordinator
        
        return taskViewController
    }
}

struct NineHoleViewController_Previews: PreviewProvider {
    static var previews: some View {
        NineHoleViewController()
    }
}

