//
//  ContentView.swift
//  SmartHMwNFC
//
//  Created by Marvin Herhaus on 18.05.21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewmodel: ViewModel = ViewModel()
    @State var helligkeit = 0.0
    @State private var nfcResult = false
    @State private var showingPopover = false
    @State var showingModal = false

        
    var body: some View{
      NavigationView {
        ZStack{
            VStack(spacing: 30){
                Spacer()
                    .frame(height:70)
                ForEach(viewmodel.model.smartObjects.indices){i in
                    ButtonView(name: viewmodel.model.smartObjects[i].name, viewmodel: viewmodel, contentView: self, isOn: viewmodel.model.smartObjects[i].isOn)
                    }
                
                Spacer()
                    .frame(height:100)
                
                Button(action: {
                    nfcResult = viewmodel.lightOnWithNFC()
                }){
                    HStack{
                        Image(systemName: "wave.3.left")
                        Text("Gerät mit NFC starten")
                        Image(systemName: "wave.3.right")
                    }
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .font(.system(size: 30))
                        
                    }
        }
        if $showingModal.wrappedValue{
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.vertical)
                VStack(spacing: 20) {
                    Text(viewmodel.pressedObject)
                        .bold().padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                    Spacer()
                    VStack {
                        Slider(value: $helligkeit, in: 0...100)
                        Text("Helligkeit: \((Int)(helligkeit))")
                            .foregroundColor(.gray)
                    }
                    Button(action: {
                        viewmodel.saveUID()
                    }){
                        Text("NFC Tag hinterlegen")
                    }
                    Spacer()
                    Button(action: {self.showingModal = false;
                        viewmodel.changeBrightness(value:helligkeit, name: viewmodel.pressedObject)
                    }){
                        Text("Speichern")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                    }
                        .frame(width: 300, height: 300)
                        .background(Color.white)
                        .cornerRadius(20).shadow(radius: 20)
                        }
                    }
        if $nfcResult.wrappedValue{
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.vertical)
                VStack(spacing: 20) {
                    Text("\(viewmodel.lastTaged) ist An / Aus")
                        .bold().padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                    Button(action: {
                        self.nfcResult = false })
                    {
                        Text("Schließen")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                }
                    .frame(width: 300, height: 100)
                    .background(Color.white)
                    .cornerRadius(20).shadow(radius: 20)
                }
            }
                        }
        .toolbar(content: {
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "plus.app")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 50 , height: 50)
                }
        })
        .navigationTitle("Smarthome")
        }
    }
}
    

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
