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

    
    let displaySeconds = 2
    let cardsCount = 4
    
    @State var totalTries = 0
    @State var cards: [Card]
    @State var userChoices = [Card]()
    
    init() {
        _cards = State(initialValue: createCardsList(count: cardsCount).shuffled())
    }
    
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
                                 width: Int(geo.size.width / 4 - 10), totalTries: $totalTries, userChoices: $userChoices)
                    }
                }
                
                VStack{
                    Text("Total tries: " + String(totalTries))
                        .foregroundColor(.white)
                        .padding()
                    
                }
            }
        }
        .background(.black)
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(displaySeconds)) {
                for card in self.cards {
                    card.turnOver()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
