//
//  SettingsView.swift
//  SmartHMwNFC
//
//  Created by Marvin Herhaus on 31.07.21.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var objectName: String = ""
    var viewmodel: ViewModel = ViewModel()

    var body: some View{
        VStack(alignment: .center, spacing: 100){
            Image(systemName:"lightbulb")
                .foregroundColor(.yellow)
                .font(.system(size: 50))
            TextField(
                    "Name der Birne",
                     text: $objectName
                )
                .autocapitalization(.none)
                .border(Color(UIColor.separator))
            .font(.system(size: 30))
            .frame(
                minWidth: 250,
                maxWidth: .infinity, minHeight: 44)
            .padding([.leading,.trailing], 10)
            .shadow(radius: 10)
            Button(action: {
                    viewmodel.newObject(name: objectName)}, label: {
                Text("Speichern")
            })
        }
        .navigationTitle("Gerät hinzufügen")
    }
}
