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
