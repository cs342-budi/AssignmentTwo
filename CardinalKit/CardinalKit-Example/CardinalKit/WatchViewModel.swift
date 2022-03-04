//
//  WatchViewModel.swift
//  CardinalKit_Example
//
//  Created by Vishnu Ravi on 2/13/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import WatchConnectivity

class WatchViewModel: NSObject, WCSessionDelegate, ObservableObject {
    
    var session: WCSession
    
    @Published var messageText = ""
    @Published var data = 0.0
    @Published var maxReceived : [Double] = []
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
        print("WatchSessionManager active")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("recieved message")
        self.messageText = message["message"] as? String ?? ""
        
        //MARK: testing arbitrary data
        self.data = message["data"] as? Double ?? 0.0
        maxReceived.append(self.data);
        //append to published array
//        let test_json = ["totalDuration": 10]
        print("RECEIVED FROM WATCH: \(self.data)")
        let uuid = UUID().uuidString
        
        // get date
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let formattedDate = dateFormatter.string(from: currDate)
        
        try! CKSendHelper.sendToFirestoreWithUUID(json: ["total-duration": message["total-duration"], "date": formattedDate], collection: "therapy-sessions", withIdentifier: uuid)
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
