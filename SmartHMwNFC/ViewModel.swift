//
//  ViewModel.swift
//  SmartHMwNFC
//
//  Created by Marvin Herhaus on 18.06.21.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    var model: MQTT = MQTT()
    var nfcReader: NFCReader = NFCReader()
    var pressedObject: String = ""
    var lastTaged: String = ""
    
    func LightON(name: String){
        model.onOFF(name: name)
    }
    
    func changeBrightness(value: Double, name: String){
        model.changeBrightness(value: value, object: findLightObject(name: name))
    }
    
    func getHelligkeit(object: String) -> Double{
        return findLightObject(name: object).helligkeit
    }
    
    func saveUID(){
        nfcReader.CaptureBtn()
        while (nfcReader.lastUID == "") {
            //wait
        }
        findLightObject(name: pressedObject).nfcTagUID = nfcReader.lastUID
    }
    
    func lightOnWithNFC()-> Bool{
        nfcReader.CaptureBtn()
        while (nfcReader.lastUID == "") {
            //wait
        }
        for elements in model.smartObjects{
            if(elements.nfcTagUID == nfcReader.lastUID){
                print("Pair found")
                self.LightON(name: elements.name)
                lastTaged = elements.name
                return true
            }
        }
        return false
    }
    
    func newObject(name: String){
        model.newObject(name: name)
    }
    
    func findLightObject(name: String) -> Light {
        for elements in model.smartObjects {
            if(elements.name == name){
                if((elements as? Light) != nil){
                    return elements as! Light
                }
            }
        }
        return Light(name: "Nicht gefunden", nfcTagUID: "")
    }
}


