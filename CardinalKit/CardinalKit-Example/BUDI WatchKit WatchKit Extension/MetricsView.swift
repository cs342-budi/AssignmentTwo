/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The workout metrics view.
 */

import SwiftUI
import HealthKit
import CoreMotion

var highestAccelaration = 0
struct MetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var cmMotionManager: CoreMotionManager
    
    //    @ObservedObject var manager = CoreMotionManager()
    
    var body: some View {
        
        TimelineView(MetricsTimelineSchedule(from: workoutManager.builder?.startDate ?? Date())) { context in
            VStack(alignment: .leading) {
               // Image(uiImage: UIImage(named: "budi logo transparent.png")!).frame(width: 1, height: 1)
                
                
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Spacer()
                        VStack {
                            Text("5").font(.largeTitle).foregroundColor(.black)
                            Text("Points").font(.caption).foregroundColor(.black)
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Spacer()
                            HStack {
                                Image(systemName: "flame.fill").imageScale(.small).foregroundColor(.black)
                                Text(workoutManager.activeEnergy.formatted(.number.precision(.fractionLength(0))) + " Cal").foregroundColor(.black).font(.caption)
                                //Text(Measurement(value: workoutManager.activeEnergy, unit: UnitEnergy.kilocalories).formatted(.measurement(width: .abbreviated, usage: .workout, numberFormatStyle: .number.precision(.fractionLength(0))))).foregroundColor(.black).font(.caption)
                            }
                            Spacer()
                            HStack {
                                Image(systemName: "heart.fill").foregroundColor(.black).imageScale(.small)
                                Text(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))) + " bpm").foregroundColor(.black).font(.caption)
                            }
                            VStack(alignment: .center) {
                                TimerViewAppleWatch(workoutTime: Int(workoutManager.builder? .elapsedTime ?? 0)).foregroundStyle(.black).font(.title3)
                                //ElapsedTimeView(elapsedTime: workoutManager.builder?.elapsedTime ?? 0, showSubseconds: false)
                                 //   .foregroundStyle(.black).font(.title3)//yellow
                                
                            }
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    
                }
                
                //                Text(Measurement(value: workoutManager.distance, unit: UnitLength.meters).formatted(.measurement(width: .abbreviated, usage: .road)))
            }
            .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
            .background(Color.green)
            .navigationTitle("Therapy")
        }
        
        
        
    }
}

//struct MetricsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MetricsView().environmentObject(WorkoutManager())
//    }
//}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    
    init(from startDate: Date) {
        self.startDate = startDate
    }
    
    func entries(from startDate: Date, mode: TimelineScheduleMode) -> PeriodicTimelineSchedule.Entries {
        PeriodicTimelineSchedule(from: self.startDate, by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
            .entries(from: startDate, mode: mode)
    }
}

