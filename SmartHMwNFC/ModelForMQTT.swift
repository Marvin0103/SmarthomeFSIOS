//
//  ModelForMQTT.swift
//  SmartHMwNFC
//
//  Created by Marvin Herhaus on 25.05.21.



import CoreNFC
import Foundation
import CocoaMQTT

class SmartObject {
    var name: String
    var nfcTagUID: String
    var isOn: Bool = false
    init(name: String, nfcTagUID: String) {
        self.name = name
        self.nfcTagUID = nfcTagUID
    }
}

class Light: SmartObject{
    var helligkeit: Double = 0.0
}


class MQTT {
    let mqttClient = CocoaMQTT(clientID: "iOS", host: "127.0.0.1", port: 1883)
    
    var light: Light = Light(name: "Birne", nfcTagUID: "04364052447081")
    var light2: Light = Light(name: "Nachtischlampe", nfcTagUID: "04364052447083")
    var light3: Light = Light(name: "Schreibtischlampe", nfcTagUID: "043e4152447080")
    var smartObjects: Array<SmartObject> = []
    
    init() {
        smartObjects.append(light)
        smartObjects.append(light2)
        smartObjects.append(light3)
    }
   
    func connect() {
        //This is the official connect function, which also check if the Client is connected.
        self.mqttClient.connect()
    }
    func disconnect() {
        self.mqttClient.disconnect()
    }
    
    func onOFF(name: String) {
        self.connect()
        let light: Light = self.findSmartObjectinList(findName: name) as! Light
        if light.isOn {
            self.mqttClient.publish("zigbee2mqtt/\(name)/set", withString: "OFF")
            light.isOn = false
            light.helligkeit = 0
            print("zigbee2mqtt/\(name)/set: OFF")
        }else {
            self.mqttClient.publish("zigbee2mqtt/\(name)/set", withString: "ON")
            light.helligkeit = 100
            light.isOn = true
            print("zigbee2mqtt/\(name)/set: ON")
        }
    }
    
    
   
    
    func changeBrightness(value: Double, object: Light) {
        if(mqttClient.connect()){
        }else{
            print("Helligkeit von \(object.name): \(value)")
            object.helligkeit = value
            let Brightness = "{\"brightness\":\(value)}"
            mqttClient.publish("zigbee2mqtt/Birne/set", withString: (Brightness))
        }
    }
    
    func findSmartObjectinList(findName: String) -> SmartObject{
        for elements in smartObjects {
            if(elements.name == findName){
                return elements
            }
        }
        return smartObjects[0]
    }
    
    func newObject(name: String){
        let light2: Light = Light(name: name, nfcTagUID: "")
        smartObjects.append(light2)
    }
 }
