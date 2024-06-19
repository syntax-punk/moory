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
    
    private let boxWidth: CGFloat = 80
    private let spacing: CGFloat = 10
    private let footerHeight: CGFloat = 180

    private var columnsCount: Int = 0
    private var rowsCount: Int = 0
    
    init() {
        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets.zero
        let usableWidth = UIScreen.main.bounds.width - safeAreaInsets.left - safeAreaInsets.right
        let usableHeight = UIScreen.main.bounds.height - safeAreaInsets.top - safeAreaInsets.bottom
                        
        let totalHorizontalSpacing = spacing * 3
        let availableWidth = usableWidth - totalHorizontalSpacing
        self.columnsCount = Int(availableWidth / (self.boxWidth + self.spacing))
        
        let totalVerticalSpacing = self.spacing * 3
        let availableHeight = usableHeight - totalVerticalSpacing - self.footerHeight
        self.rowsCount = Int(availableHeight / (self.boxWidth + self.spacing))
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                Header(openSettings: $openSettings)
                
                let gridItems = Array(repeating: GridItem(.flexible(), spacing: self.spacing), count: self.columnsCount)
                
                LazyVGrid(columns: gridItems, spacing: spacing) {
                    ForEach(cards){ card in
                        CardView(
                            card: card,
                            width: Int(self.boxWidth),
                            totalTries: $totalTries,
                            userChoices: $userChoices
                        )
                        .frame(width: self.boxWidth)
                    }
                }
                
                Footer(totalTries: $totalTries, startApp: {
                    self.startApp()
                })
                .padding()
            }
            .onAppear {
                self.startApp()
            }
        }
        .background(.black)
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
        let totalCards = self.columnsCount * self.rowsCount
        
        let count = Int(cardsCount) ?? 4
        let time = Float(displayTime) ?? 1
        
        cards = createCardsList(count: count, total: totalCards).shuffled()
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
