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
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State var totalTries = 0
    @State var cards: [Card]
    @State var userChoices = [Card]()
    @State var showResults = false
    
    @State private var secondsElapsed = 0
    @State private var timer: Timer?
    
    init() {
        _cards = State(initialValue: createCardsList(count: cardsCount).shuffled())
    }
    
    func startApp() {
        cards = createCardsList(count: cardsCount).shuffled()
        totalTries = 0
        userChoices = [Card]()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(displaySeconds)) {
            for card in self.cards {
                card.turnOver()
            }
        }
        
        startTimer()
    }
    
    var body: some View {
        GeometryReader{geo in
            VStack{
                Text("moory")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                
                LazyVGrid(columns: fourColGrid, spacing: 10) {
                    ForEach(cards){ card in
                        CardView(card: card,
                                 width: Int(geo.size.width / 4 - 10), totalTries: $totalTries, userChoices: $userChoices)
                    }
                }
                
                HStack{
                    Text("Total tries: " + String(totalTries))
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    Button{
                        startApp()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                    }
                }
                .padding()
            }
        }
        .background(.black)
        .onAppear(){
            self.startApp()
        }
        .onChange(of: totalTries){
            let result = self.userChoices.count == self.cardsCount
            if result {
                stopTimer()
            }
            self.showResults = result
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .background:
                stopTimer()
            default:
                break
            }
        }
        .fullScreenCover(isPresented: $showResults) {
            ResultsView(totalTries: $totalTries, timeSpent: $secondsElapsed)
        }
    }
    
    func startTimer() {
        if timer == nil {
            self.secondsElapsed = 0
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.secondsElapsed += 1
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    ContentView()
}
