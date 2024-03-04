//
//  ResultsView.swift
//  moory
//
//  Created by David on 29/02/2024.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var totalTries: Int
    @Binding var timeSpent: Int
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.25)
                .blur(radius: 10)
            
            VStack(spacing: 32) {
                Spacer()
                VStack {
                    Text("Total Tries: \(totalTries)")
                        .font(.title2)
                        .padding()
                    Text("Time Spent: \(timeSpent) sec")
                        .font(.title2)
                        .padding()
                }
                
                
                
                Spacer()
                
                Button() {
                    self.dismiss()
                } label: {
                    Text("Dismiss")
                        .font(.title)
                        .foregroundStyle(Color(.white))
                        .padding()
                }
                .background(.black)
                .cornerRadius(12)
                Spacer()
            }
        }

    }
}
