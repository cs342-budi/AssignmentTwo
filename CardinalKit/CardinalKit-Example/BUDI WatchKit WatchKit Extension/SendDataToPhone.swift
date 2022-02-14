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

class SendDataToPhone: NSObject, WCSessionDelegate {
    
    var session: WCSession
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }

}
