//
//  WatchViewModel.swift
//  CardinalKit_Example
//
//  Created by Vishnu Ravi on 2/13/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Firebase
import FirebaseFirestore
import Foundation
import WatchConnectivity

class WatchViewModel: NSObject, WCSessionDelegate, ObservableObject {
    
    var session : WCSession
    
    @Published var messageText = ""
    @Published var data = 0.0
    @Published var maxReceived : [Double] = []
    @Published var points : Double = 0.0
    @Published var progressToNext : Double = 0.0
    @Published var timerMessage : String = "RESUME"
    
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
        print("WatchSessionManager active")
    }
    
//    deinit {
//        session.delegate = nil
//        // stop watch session when paused/ended
//    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        //print("recieved message")
//        self.messageText = message["message"] as? String ?? ""
        DispatchQueue.main.async {
            //if message that comes in has a data point, add it to the array of data points
            // data key exist? Does this key cast to a double? Add it to to array if succeeeded
            if let datapoint = message["data"] as? Double  {
            //MARK: testing arbitrary data
            self.data = datapoint  // we alr we know its a double
            self.maxReceived.append(self.data);
            //append to published array
    //        let test_json = ["totalDuration": 10]
            print("RECEIVED FROM WATCH: \(self.data)")
            }
            
            // Points
            if let points = message["points"] as? Double {
                self.points = points
                print("Points from watch: \(self.data)")
                self.progressToNext = (points * 100).truncatingRemainder(dividingBy: 100) / 100.0
                print("Progress to next point \(self.progressToNext)")
                
                
            }
            
            if let timerMsg = message["message"] as? String {
                self.timerMessage = timerMsg
                //print(self.pauseMessage)
                print("Timer Received from Watch. Message: \(timerMsg)")
            }
            
            // Pause/Resume timer
            

            // if total duration exists - it could be any messages so check!!
            print("\(message["total-duration"]) + hello")
            if let totalduration = message["total-duration"] as? Double {  // convert to int
            let uuid = UUID().uuidString
            print("received the value \(totalduration)")
            //send start
            // get date
                // document called mm dd yyyy
                // summation
            
            let currDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let formattedDate = dateFormatter.string(from: currDate)
            var totaltime = totalduration  // start with the watch's duration! thena add running total on the bottom

            // checking if user is loggin in
                guard let authCollection =  CKStudyUser.shared.authCollection else { return } // stop executing if not logged in
                let db = Firestore.firestore()
                let collectionRef = db.collection(authCollection + "therapy-sessions")// ref to specific col for data
                
                //variable for total # of seconds
                // compare if we have the doc. put the number into existing doc.
                
                collectionRef.document(formattedDate).getDocument() {
                    (document, error) in
                    if let document = document,
                       // if doc exist, get datapoint
                       document.exists {
                        let data = document.data() //data
                        // if we succeed, we got sec of data, swap 0 in if theres no data
                        let payload = data?["payload"] as? [String : Any]  // cast payload to dic
                        let runningtotal = payload?["totaltime"] as? Double ?? 0 // get document's data of total time
                        print("\(runningtotal) + runingningtime")
                        totaltime += runningtotal   // accumulate the data
                        //update doc with cur data 1)doc doesn't exist
                    } else {
                        print("document doesn't exist")
                    }
                    // run after data is back
                    print("\(totaltime) + totaltimehellooooo")
                    do { try CKSendHelper.sendToFirestoreWithUUID(json: ["totaltime": totaltime, "date": Date().timeIntervalSinceReferenceDate], collection: "therapy-sessions", withIdentifier: formattedDate)
                    } catch {
                        print("somthing went wrong!!!!")
                    }
                }
                
                //add total duration
                
            // create array in of document
            // array has number of seconds of each therapy session of that day
            // array of session durations - add new element - how many each day..easily sum up..
                
                //chart = get today's document - array of session duration. map
            // catch error
                //send other document that has total duratoin of the day
                
    //            do { try CKSendHelper.sendToFirestoreWithUUID(json: ["total-duration": totalduration, "date": formattedDate], collection: "therapy-sessions", withIdentifier: uuid)
    //            } catch {
    //                print("somthing went wrong!!!!")
    //            }
            }
        } // dispatch queue closure
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("received message")
        self.messageText = message["message"] as? String ?? ""
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
}
