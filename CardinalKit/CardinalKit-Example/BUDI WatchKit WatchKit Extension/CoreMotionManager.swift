//
//  CMMotionManager.swift
//  BUDI WatchKit Extension
//
//  Created by Tracy Cai on 1/26/22.
//

import Foundation
import HealthKit
import CoreMotion

//provide updated data to views
class CoreMotionManager: NSObject, ObservableObject {
    @Published var accelaration: Double = 0.0
    @Published var acclerationHistory: [Double] = [10.0, 20.0, 30.0]
    var meanAccelaration: Double = 0.0
    var motion: CMMotionManager!
    var timer: Timer?
    override init(){
        super.init()
        print("CMmanager init")
        self.motion = CMMotionManager()
        self.startAccelerometers()
    }
    
    func getMeanAccelaration(){
        meanAccelaration = acclerationHistory.reduce(0,+)/Double(acclerationHistory.count)
    }
    
    func startAccelerometers() {
        self.accelaration += 1
       // Make sure the accelerometer hardware is available.
       if self.motion.isAccelerometerAvailable {
          self.motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
          self.motion.startAccelerometerUpdates()
           print("start")
//          // Configure a timer to fetch the data.
//          self.timer = Timer(fire: Date(), interval: (1.0/60.0),
//                repeats: true, block: { (timer) in
//             // Get the accelerometer data.
//              print("inside timer")
             if let data = self.motion.accelerometerData {
                let x = data.acceleration.x
                let y = data.acceleration.y
                let z = data.acceleration.z
//
//                // Use the accelerometer data in your app.
                print("inside if")
                acclerationHistory.append(x)
                self.accelaration = x
             }
//          })

          // Add the timer to the current run loop.
//           RunLoop.current.add(self.timer!, forMode: .default)
       }
    }

}


