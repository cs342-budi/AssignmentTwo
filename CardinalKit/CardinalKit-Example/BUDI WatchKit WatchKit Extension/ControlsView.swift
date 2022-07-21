/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The workout controls.
 */

import SwiftUI
import CoreMotion

struct ControlsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var cmMotionManager: CoreMotionManager
    var body: some View {
        HStack {
            VStack {
                Button {
                    workoutManager.endWorkout()
                    cmMotionManager.getMeanAccelaration()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(.red)
                .font(.title2)
                Text("End")
            }
            VStack {
                Button {
                    workoutManager.togglePause()
                    
                    if SendDataToPhone.shared.session.isReachable { // Pause Pressed
                        
                        if workoutManager.running { // Pause Pressed
                            //send data to phone
                            print("SENDING PAUSE TO PHONE")
                            SendDataToPhone.shared.session
                                .sendMessage(["message":"PAUSE"], replyHandler: nil, errorHandler: { (err) in print (err.localizedDescription)})
                        }
                        else { // Resume Pressed
                            // send data to phone
                            print("SENDING RESUME TO PHONE")
                            SendDataToPhone.shared.session
                                .sendMessage(["message":"RESUME"], replyHandler: nil, errorHandler: { (err) in print (err.localizedDescription)})
                        }
                        
                    }
                    
                } label: {
                    Image(systemName: workoutManager.running ? "pause" : "play")
                }
                .tint(.yellow)
                .font(.title2)
                Text(workoutManager.running ? "Pause" : "Resume")
            }
        }
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView().environmentObject(WorkoutManager())
    }
}

