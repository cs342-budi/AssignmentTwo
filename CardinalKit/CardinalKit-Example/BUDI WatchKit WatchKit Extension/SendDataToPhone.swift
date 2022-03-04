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
    
    //MARK: changed this to singleton 
    static let shared = SendDataToPhone()
    
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
    
    // MARK: added private b/c singleton
    private init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
        print("INITIALIZED SINGLETON")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // this stub is not implemented
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        // MARK: Taylor
        // This method is called when a message is received from the phone
        // We will extract the "action" key if it exists and then set it to
        // the *action* variable above, which will trigger a notification to the
        // main view.
        
        self.action = message["action"] as? String ?? ""
        print(self.action)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        // MARK: Taylor
        // This is the same method as above, but it also allows us to
        // provide a reply back to the phone using the *replyHandler*
        // if we want to.
        
        self.action = message["action"] as? String ?? ""
        print(self.action)
    }

}
