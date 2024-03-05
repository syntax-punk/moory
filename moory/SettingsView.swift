//
//  SettingsView.swift
//  moory
//
//  Created by David on 04/03/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var displayTime: String
    @Binding var cardsCount: String

    let timeList = ["0.25", "0.5", "1", "1.5", "2"]
    let cardsList = ["4", "5", "6", "8", "10"]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.25)
                .blur(radius: 10)
            
            VStack(spacing: 32) {
                Form {
                    Section(header: Text("Display time (seconds)")) {
                        Picker("Seconds: ", selection: $displayTime) {
                           ForEach(timeList, id: \.self) {
                               Text($0)
                           }
                       }
                    }
                    .pickerStyle(.segmented)
                    
                    Section(header: Text("Number of cards")) {
                        Picker("Cards: ", selection: $cardsCount) {
                           ForEach(cardsList, id: \.self) {
                               Text($0)
                           }
                       }
                    }
                    .pickerStyle(.segmented)
                }
                .background(.clear)
                
                Button() {
                    self.dismiss()
                } label: {
                    Text("Back")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(.black)
                }
                .border(.white, width: 2)
                .cornerRadius(4)
                
                Spacer()
            }
        }
    }
}
