//
//  Footer.swift
//  moory
//
//  Created by David on 05/03/2024.
//

import SwiftUI

struct Footer: View {
    @Binding var totalTries: Int
    var startApp: () -> Void

    var body: some View {
        HStack{
            Text("Total tries: " + String(totalTries))
                .foregroundColor(.white)
                .padding()
            Spacer()
            Button{
                startApp()
            } label: {
                Image(systemName: "arrow.clockwise")
                    .font(.system(.title))
                    .foregroundColor(.white)
            }
        }
    }
}
