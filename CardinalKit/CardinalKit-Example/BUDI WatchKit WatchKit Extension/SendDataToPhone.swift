//
//  SendDataToPhone.swift
//  BUDI WatchKit Extension
//
//  Created by Tracy Cai on 2/2/22.
//

import Foundation
import SwiftUI
import Combine

import WatchConnectivity

class SendDataToPhone: NSObject, WCSessionDelegate, ObservableObject {

    
    var session: WCSession
    
    // MARK: Taylor
    // When we recieve a message from the phone to start the workout
    // the *action* variable is set with the contents of the message.
    // Then, we send a notification to any subscribers using *actionNotification*
    // that a message has been received.
    //
    // In contentview, we subscribe to *actionNotification*, and when a value passes
    // through, it will react by either starting or stopping the therapy.
     
    public let actionNotification = PassthroughSubject<String,Never>()
    //fyi, passthroughsubject just passes values along to subscribers
    
    public private(set) var action: String = "" {
        willSet {
            
            // MARK: Taylor
            // this code is executed when the action variable is about to be
            // set, and the value to be set is contained in *newValue*
            // We will send a notification to our content view with the value
            
            DispatchQueue.main.async { [weak self] in // Publish on main thread
                self?.actionNotification.send(newValue)
            }
        }
    }
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // this stub is not implemented
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        self.action = message["action"] as? String ?? ""
        print(self.action)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        self.action = message["action"] as? String ?? ""
        print(self.action)
    }

}
