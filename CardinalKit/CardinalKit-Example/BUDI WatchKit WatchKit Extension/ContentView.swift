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
    var workoutTypes: [HKWorkoutActivityType] = [.flexibility]
    @EnvironmentObject var cmManager : CoreMotionManager
    
    //var phoneViewModel = SendDataToPhone()
    
    var body: some View {
        VStack{
            //MARK: initiate session with phone when start therapy tapped from watch
            List(workoutTypes){ workoutType in
                HStack{
                    Spacer()
                    NavigationLink(workoutType.name,
                                                   destination: SessionPagingView(),
                                                   tag: workoutType, selection: $workoutManager.selectedWorkout
                    ).padding(
                        EdgeInsets(top: 65, leading: 0, bottom: 65, trailing: 0)
                    )
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    Spacer()
                }.background(Color.green)
                    .cornerRadius(15)
                    .padding(
                        EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                    )
            }
            .listStyle(.carousel)
            .navigationBarTitle("BUDI")
            .onAppear {
                workoutManager.requestAuthorization()
                if SendDataToPhone.shared.session.isReachable {
                    print("Session reached")
                } else {
                    print("Session not reached.")
                }
                
            }
            .onReceive(SendDataToPhone.shared.actionNotification){ action in
                // MARK: Taylor
                // We subscribe to *actionNotification* from the viewModel to listen for a notification
                // then based on the message we got, we either start or stop the therapy session.
                
                switch action {
                    case "THERAPY_START":
                        if !workoutManager.running {
                            print("Starting therapy...")
                            // setting the workout type triggers it to start
                            workoutManager.selectedWorkout = workoutTypes.first
                            cmManager.startAccelerometers()
                            
                        } else {
                            print("Therapy has already been started.")
                        }
                        
                    case "THERAPY_STOP":
                        if workoutManager.running {
                            print("Stopping therapy...")
                            cmManager.stopAccelerometers()
                            workoutManager.endWorkout()
                        } else {
                            print("Therapy hasn't been started.")
                        }
                    default:
                        return
                }
                
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
        case .flexibility:
            return "Therapy"
        default:
            return ""
        }
    }
}

