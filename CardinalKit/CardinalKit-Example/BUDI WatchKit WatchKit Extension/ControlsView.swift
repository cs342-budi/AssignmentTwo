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
                    
                    if workoutManager.running {
                        print("Pause Pressed")
                        workoutManager.session?.pause()
                        
                        if SendDataToPhone.shared.session.isReachable {
                            //send data to phone
                            print("SENDING PAUSE TO PHONE")
                            SendDataToPhone.shared.session
                                .sendMessage(["message":"PAUSE_PRESSED"], replyHandler: nil, errorHandler: { (err) in print (err.localizedDescription)})
                    }
                        
                        // send message to phone
                    }
                    else {
                        if SendDataToPhone.shared.session.isReachable {
                            workoutManager.session?.resume()
                            //send data to phone
                            print("SENDING RESUME TO PHONE")
                            SendDataToPhone.shared.session
                                .sendMessage(["message":"RESUME_PRESSED"], replyHandler: nil, errorHandler: { (err) in print (err.localizedDescription)})
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

