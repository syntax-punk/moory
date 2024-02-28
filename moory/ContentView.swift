//
//  ContentView.swift
//  moory
//
//  Created by David on 28/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    private var fourColGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    private var sixColGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    @State var cards = createCardList().shuffled()
    @State var matchedCards = [Card]()
    @State var userChoices = [Card]()
    
    var body: some View {
        GeometryReader{geo in
            VStack{
                Text("moory")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)
                
                LazyVGrid(columns: fourColGrid, spacing: 10) {
                    ForEach(cards){ card in
                        CardView(card: card,
                                 width: Int(geo.size.width / 4 - 10), matchedCards: $matchedCards, userChoices: $userChoices)
                    }
                }
                
                VStack{
                    Text("Find these cards:")
                        .foregroundColor(.white)
                    LazyVGrid(columns: sixColGrid, spacing: 4){
                        ForEach(cardValues, id:\.self) { cardValue in
                            if !matchedCards.contains(where: {
                                $0.text == cardValue
                            }) {
                                Text(cardValue)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                }
            }
        }
        .background(.black)
    }
}

#Preview {
    ContentView()
}
