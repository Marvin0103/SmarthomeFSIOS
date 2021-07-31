//
//  ButtonView.swift
//  SmartHMwNFC
//
//  Created by Marvin Herhaus on 31.07.21.
//

import SwiftUI

struct ButtonView: View {
    var name: String
    @State private var helligkeit = 50.0
    @ObservedObject var viewmodel: ViewModel
    @State var contentView: ContentView
    @State var isOn: Bool
    
    var body: some View{
        ZStack {
            Button( action:{contentView.showingModal = true; viewmodel.pressedObject = name; contentView.helligkeit = viewmodel.getHelligkeit(object: viewmodel.pressedObject)}){
                    HStack {
                        Image(systemName:"lightbulb")
                            .foregroundColor(isOn ? .yellow : .black)
                        Text(name)
                    }
                        .foregroundColor(.white)
                        .font(Font.subheadline.weight(.bold))
                        .frame(
                            minWidth: 250,
                            maxWidth: .infinity, minHeight: 44
                        )
                }
                .background(Color.blue)
                .padding([.leading,.trailing], 15)
                .shadow(radius: 10)
                
                Button(action:{
                    viewmodel.LightON(name: name);isOn = (isOn ? false: true)
                                }){
                                    Image(systemName: "power")
                                }
                .foregroundColor(Color.white)
                                .font(.system(size: 35))
                                .border(Color.white, width: 1)
                                .offset(x: 125)
        }
    }
}
    
