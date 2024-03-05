//
//  ContentView.swift
//  moory
//
//  Created by David on 28/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    private var fourColGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("displayTime") private var displayTime = "1"
    @AppStorage("cardsCount") private var cardsCount = "4"
    
    @State var totalTries = 0
    @State var cards: [Card] = []
    @State var userChoices = [Card]()
    @State var showResults = false
    @State var openSettings = false
    
    @State private var secondsElapsed = 0
    @State private var timer: Timer?
    @State private var isReadyToStart = true
    
    var body: some View {
        GeometryReader{geo in
            VStack{
                Header(openSettings: $openSettings)
                
                LazyVGrid(columns: fourColGrid, spacing: 10) {
                    ForEach(cards){ card in
                        CardView(
                            card: card,
                            width: Int(geo.size.width / 4 - 10),
                            totalTries: $totalTries,
                            userChoices: $userChoices
                        )
                    }
                }
                
                Footer(totalTries: $totalTries, startApp: startApp)
                .padding()
            }
        }
        .background(.black)
        .onAppear(){
            self.startApp()
        }
        .onChange(of: totalTries){ newValue in
            let result = self.userChoices.count == Int(self.cardsCount)
            if result {
                stopTimer()
            }
            self.showResults = result
        }
        .onChange(of: scenePhase) { newValue in
            switch newValue {
            case .background:
                stopTimer()
            default:
                break
            }
        }
        .fullScreenCover(isPresented: $showResults) {
            ResultsView(totalTries: $totalTries, timeSpent: $secondsElapsed)
        }
        .fullScreenCover(isPresented: $openSettings) {
            SettingsView(displayTime: $displayTime, cardsCount: $cardsCount)
        }
    }
    
    func startApp() {
        if !isReadyToStart {
            return
        }
        
        let count = Int(cardsCount) ?? 4
        let time = Float(displayTime) ?? 1
        
        cards = createCardsList(count: count).shuffled()
        totalTries = 0
        userChoices = [Card]()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat(time)) {
            for card in self.cards {
                card.turnOver()
            }
            isReadyToStart = true
        }
        
        isReadyToStart = false
        startTimer()
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
