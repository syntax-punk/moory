//
//  CardModel.swift
//  moory
//
//  Created by David on 28/02/2024.
//

import Foundation
import SwiftUI

class Card: Identifiable, ObservableObject {
    var id = UUID()
    @Published var isFaceUp = true
    @Published var isMatched = false
    
    var text: String
    
    init(text:String) {
        self.text = text
    }
    
    func turnOver() {
        self.isFaceUp.toggle()
    }
}

var cardsOrder:[Card] = []

func createCardsList(count: Int) -> [Card] {
    var tempOrder = [Int]()
    
    var cardList = [Card]()
    
    for i in 0..<24 {
        if i < count {
            let num = Int.random(in: 10..<100)
            cardList.append(Card(text: String(num)))
            tempOrder.append(num)
        } else {
            cardList.append(Card(text: ""))
        }
    }
    
    tempOrder.sort()
    for value in tempOrder {
        cardsOrder.append(Card(text: String(value)))
    }
    
    return cardList
}

let faceDownCard = Card(text: "")
