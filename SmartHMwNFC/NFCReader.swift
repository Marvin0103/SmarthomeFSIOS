//
//  NFCReader.swift
//  SmartHMwNFC
//
//  Created by Marvin Herhaus on 27.07.21.
//

import Foundation
import CoreNFC

class NFCReader: NSObject, NFCTagReaderSessionDelegate {
    
    var session: NFCTagReaderSession?
    var lastUID: String = ""
    
    func CaptureBtn() {
            self.session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
            self.session?.alertMessage = "Halte das iPhone in die Nähe des NFC Tag"
            self.session?.begin()
    }
        
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("Session Begin")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print("Error")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print("Connecting To Tag")
                if tags.count > 1{
                    session.alertMessage = "More Than One Tag Detected, Please try again"
                    session.invalidate()
                }
                let tag = tags.first!
                session.connect(to: tag) { (error) in
                    if nil != error{
                        session.invalidate(errorMessage: "Connection Failed")
                    }
                    if case let .miFare(sTag) = tag{
                        let UID = sTag.identifier.map{ String(format: "%.2hhx", $0)}.joined()
                        print("UID:", UID)
                        print(sTag.identifier)
                        session.alertMessage = "Tag wurde gelesen"
                        session.invalidate()
                        let text: String = "\(UID)"
                        self.lastUID = text
                    }
                }
    }
    
    func checkUID(lastUI: String, uIDforCheck: String)-> Bool{
        CaptureBtn()
        if(lastUI == uIDforCheck){
            return true
        }
        return false
    }
}

