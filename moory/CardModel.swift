//
//  MooryData.swift
//  moory
//
//  Created by David on 28/02/2024.
//

import Foundation
import SwiftUI

class Card: Identifiable, ObservableObject {
    var id = UUID()
    @Published var isFaceUp = false
    @Published var isMatched = false
    
    var text: String
    
    init(text:String) {
        self.text = text
    }
    
    func turnOver() {
        self.isFaceUp.toggle()
    }
}

let cardValues:[String] = [
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"
]

func createCardList() -> [Card] {
    var cardList = [Card]()
    
    for cardValue in cardValues {
        cardList.append(Card(text: cardValue))
        cardList.append(Card(text: cardValue))
    }
    
    return cardList
}

let faceDownCard = Card(text: "-")
