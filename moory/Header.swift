//
//  Header.swift
//  moory
//
//  Created by David on 05/03/2024.
//

import SwiftUI

struct Header: View {
    @Binding var openSettings: Bool
    
    var body: some View {
        HStack{
            Text("moory")
                .font(.title)
                .padding()
                .foregroundColor(.white)
            
            Spacer()
            
            Button{
                openSettings.toggle()
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}
