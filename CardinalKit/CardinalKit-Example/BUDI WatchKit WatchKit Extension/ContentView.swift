/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The start view.
 */

import SwiftUI
import HealthKit
import simd

struct ContentView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    //    var workoutTypes: [HKWorkoutActivityType] = [.cycling, .running, .walking]
    var workoutTypes: [HKWorkoutActivityType] = [.walking]
    var phoneViewModel = SendDataToPhone()
    var body: some View {
        VStack{
            Button(action: {
                if self.phoneViewModel.session.isReachable {
                    print("phone is reachable")
                    self.phoneViewModel.session.sendMessage(["message": "Message Received from Watch!!"], replyHandler: nil, errorHandler: { (err) in
                        print(err.localizedDescription)
                    })
                } else {
                    print("can't reach phone.")
                }
            }) {
                Text("Test Connection")
            }
            List(workoutTypes){ workoutType in
                NavigationLink(workoutType.name,
                               destination: SessionPagingView(),
                               tag: workoutType, selection: $workoutManager.selectedWorkout
                ).padding(
                    EdgeInsets(top: 80, leading: 5, bottom: 80, trailing: 5)
                ).font(.system(size: 24, weight: .bold))
                    .foregroundColor(.green)
                
                
            }
            .listStyle(.carousel)
            .navigationBarTitle("Workouts")
            .onAppear {
                workoutManager.requestAuthorization()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(WorkoutManager())
    }}

extension HKWorkoutActivityType: Identifiable{
    public var id: UInt{
        rawValue
    }
    
    var name: String{
        switch self {
            
            //        case .running:
            //            return "Run"
            //        case .cycling:
            //            return "Bike"
        case .walking:
            return "    Stretch Arm"
        default:
            return ""
        }
    }
}

