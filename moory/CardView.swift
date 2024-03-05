//
//  CardView.swift
//  moory
//
//  Created by David on 28/02/2024.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var card: Card
    
    let width: Int
    
    @Binding var totalTries: Int
    @Binding var userChoices: [Card]
    
    var body: some View {
        if card.isFaceUp
        {
            Text(card.text)
                .font(.system(.largeTitle))
                .foregroundColor(.white)
                .padding()
                .frame(width: CGFloat(width), height: CGFloat(width))
                .background(Color.black)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.gray, lineWidth: 0.5)
                )
        } else {
            Text("")
                .font(.system(.largeTitle))
                .foregroundColor(.white)
                .padding()
                .frame(width: CGFloat(width), height: CGFloat(width))
                .background(Color.black)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.gray, lineWidth: 0.5)
                )
                .onTapGesture {
                    
                    if userChoices.count == cardsOrder.count {
                        return
                    }
                    
                    var tempChoices = userChoices
                    tempChoices.append(card)
                    
                    let tempIndex = tempChoices.firstIndex(where: { $0.text == card.text })
                    let orderIndex = cardsOrder.firstIndex(where: { $0.text == card.text })
                    
                    if (tempIndex == orderIndex) {
                        card.turnOver()
                        userChoices.append(card)
                    }
                    
                    totalTries += 1
                }
        }
    }
}
