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
    @Published var accelerationHistory: [Double] = []
    
    var meanAccelaration: Double = 0.0
    var motion: CMMotionManager!
    
    ///Timer is for point calculation
    private var workoutTime = 0.0
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            self.workoutTime += 1
        }
    }
    
//    var points : Double = 0.0
    var accelArray : [Double] = []
    var maxArray : [Double] = []
    fileprivate let dmUserAccelSemaphore = DispatchSemaphore(value: 1)
    
    fileprivate lazy var motionQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        queue.maxConcurrentOperationCount = 9
        return queue
    }()
  
    
    override init(){
        super.init()
        print("CMmanager init")
        self.motion = CMMotionManager()
    }
    
    func getMeanAccelaration(){
        meanAccelaration = accelerationHistory.reduce(0,+)/Double(accelerationHistory.count)
    }
    
    func startAccelerometers() {
        
        self.accelaration += 1
       // Make sure the accelerometer hardware is available.

        
       
        if self.motion.isDeviceMotionAvailable {
            print("MOTION AVAILABLE")
            self.motion.deviceMotionUpdateInterval = 1.0/60.0
            self.motion.startDeviceMotionUpdates(to: motionQueue, withHandler: { [weak self] (data: CMDeviceMotion?, error: Error?) in
                
                guard let strongSelf = self else {
                    return
                }
                
                if let data = data  {
                    
                    strongSelf.dmUserAccelSemaphore.wait()
                        let xVal = data.userAcceleration.x
                        strongSelf.accelArray.append(xVal)
                        print("THIS IS THE XVAL \(xVal)")
                        if strongSelf.accelArray.count > 300 { //60 * 1 (once a second)
                            if let max = strongSelf.accelArray.max() {
                                self?.maxArray.append(max)
                                self?.accelaration = max
                                let pointsToSend = self!.workoutTime/120 + self!.maxArray.reduce(0, +) / 60
                                
                                    if SendDataToPhone.shared.session.isReachable {
                                        //send data to phone
                                        print("SENDING MAX TO PHONE")
                                        SendDataToPhone.shared.session.sendMessage(["data": max], replyHandler: nil, errorHandler: { (err) in print (err.localizedDescription)})
                                        SendDataToPhone.shared.session.sendMessage(["points": pointsToSend], replyHandler: nil, errorHandler: { (err) in print (err.localizedDescription)})
                                }
                                self?.accelerationHistory.append(max)
                            }
                            //clear array
                            strongSelf.accelArray.removeAll()
                        }
                    strongSelf.dmUserAccelSemaphore.signal()
                    }
                })
        } else {
            print("motion not available :(")
        }
        
        
    
//
//       if self.motion.isAccelerometerAvailable {
//          self.motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
//          self.motion.startAccelerometerUpdates()
//           print("start")
//
////          // Configure a timer to fetch the data.
////          self.timer = Timer(fire: Date(), interval: (1.0/60.0),
////                repeats: true, block: { (timer) in
////             // Get the accelerometer data.
////              print("inside timer")
//             if let data = self.motion.accelerometerData {
//                let x = data.acceleration.x
////                let y = data.acceleration.y
////                let z = data.acceleration.z
////
////                // Use the accelerometer data in your app.
//                print("inside if")
//                acclerationHistory.append(x)
//                self.accelaration = x
//
//
//                 if SendDataToPhone.shared.session.isReachable {
//                     //send data to phone
//                     print("SENDING DATA TO PHONE")
//                     SendDataToPhone.shared.session.sendMessage(["data": self.accelaration], replyHandler: nil, errorHandler: { (err) in print (err.localizedDescription)})
//             }
//
//             }
////          })
//
//          // Add the timer to the current run loop.
////           RunLoop.current.add(self.timer!, forMode: .default)
//       }
    }



    func stopAccelerometers () {
        self.motion.stopAccelerometerUpdates()
        self.motion.stopDeviceMotionUpdates()
    }

}
