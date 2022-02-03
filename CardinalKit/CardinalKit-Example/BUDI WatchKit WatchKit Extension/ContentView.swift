/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The start view.
*/

import SwiftUI
import HealthKit

struct ContentView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
//    var workoutTypes: [HKWorkoutActivityType] = [.cycling, .running, .walking]
    var workoutTypes: [HKWorkoutActivityType] = [.walking]
    var model = SendDataToPhone()
    var body: some View {
        // send data to phone through a button click
//        Button(action: {
//            self.model.session.sendMessage(["message" : "test!!"], replyHandler: nil) { (error) in
//                print(error.localizedDescription)
//            }
//        }) {
//        Text("Send Message")
//        }
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

