//
//  CardListViewModel.swift
//  Cards
//
//  Created by Armin on 9/25/22.
//

import Foundation

class CardListViewModel: ObservableObject {
    
    @Published var knownCards: [Card] = []
    @Published var forgottenCards: [Card] = []
    @Published var reloadToken = UUID()
    
    func addKnownCard(_ card: Card) {
        self.knownCards.append(card)
    }
    
    func addForgottenCard(_ card: Card) {
        self.forgottenCards.append(card)
    }
    
    func resetStats() {
        self.knownCards.removeAll()
        self.forgottenCards.removeAll()
    }
}
