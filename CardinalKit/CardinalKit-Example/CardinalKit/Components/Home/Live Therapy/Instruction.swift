//
//  Instruction.swift
//  CardinalKit_Example
//
//  Created by Mihir Joshi on 4/30/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import AVFoundation
import AVKit

struct Instruction1: Identifiable, Hashable {
    
    
    var id = UUID().uuidString
    var title: String
    //var video: VideoPlayer<Overlay>
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}


