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
    
    @Binding var matchedCards: [Card]
    @Binding var userChoices: [Card]
    
    var body: some View {
        if card.isFaceUp || matchedCards.contains(where: { $0.id == card.id })
        {
            Text(card.text)
                .font(.system(size: 50))
                .foregroundColor(.white)
                .padding()
                .frame(width: CGFloat(width), height: CGFloat(width))
                .background(Color.black)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 2)
                )
        } else {
            Text("-")
                .font(.system(size: 50))
                .foregroundColor(.white)
                .padding()
                .frame(width: CGFloat(width), height: CGFloat(width))
                .background(Color.black)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 2)
                )
                .onTapGesture {
                    if userChoices.count == 0 {
                        card.turnOver()
                        userChoices.append(card)
                    } else if userChoices.count == 1 {
                        card.turnOver()
                        userChoices.append(card)
                        
                        withAnimation(Animation.linear.delay(1)){
                            for thisCard in userChoices {
                                thisCard.turnOver()
                            }
                        }
                        
                        checkForMatch()
                    }
                }
        }
    }
    
    func checkForMatch() {
        if userChoices[0].text == userChoices[1].text {
            matchedCards.append(userChoices[0])
            matchedCards.append(userChoices[1])
        }
        
        userChoices.removeAll()
    }
}
