//
//  CardStats.swift
//  Cards
//
//  Created by Armin on 9/27/22.
//

import SwiftUI

struct Stats: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: CardListViewModel
    
    @AppStorage("leftOptionIcon") var leftOptionIcon: String = "hand.thumbsdown.circle"
    @AppStorage("leftOptionTitle") var leftOptionTitle: String = "Forgotten"
    
    @AppStorage("rightOptionIcon") var rightOptionIcon: String = "hand.thumbsup.circle"
    @AppStorage("rightOptionTitle") var rightOptionTitle: String = "Known"
    
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(iOS)
                Color("BackgroundColor")
                    .ignoresSafeArea(.all)
                #endif
                
                content
            }
        }
    }
    
    var content: some View {
        List {
            Section {
                ForEach(model.forgottenCards) { card in
                    Text("\(card.front ?? ""): \(card.back ?? "")")
                }
                
                if model.forgottenCards.isEmpty {
                    Text("The \(leftOptionTitle) list is empty")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Label(leftOptionTitle, systemImage: leftOptionIcon)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.red.gradient)
            }
            #if os(iOS)
            .listRowBackground(Color("BackgroundSecondColor"))
            #endif
            
            Section {
                ForEach(model.knownCards) { card in
                    Text("\(card.front ?? ""): \(card.back ?? "")")
                }
                
                if model.knownCards.isEmpty {
                    Text("The \(rightOptionTitle) list is empty")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Label(rightOptionTitle, systemImage: rightOptionIcon)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.green.gradient)
            }
            #if os(iOS)
            .listRowBackground(Color("BackgroundSecondColor"))
            #endif
        }
        #if os(macOS)
        .listStyle(.inset(alternatesRowBackgrounds: true))
        .frame(minWidth: 350, minHeight: 500)
        #elseif os(iOS)
        .scrollContentBackground(.hidden)
        #endif
        .navigationTitle("Stats")
        .toolbar {
            ToolbarItem {
                Button {
                    dismiss()
                } label: {
                    Label("Close", systemImage: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                }
            }
        }
    }
}

struct CardStats_Previews: PreviewProvider {
    struct Preview: View {
        
        @StateObject var model = CardListViewModel()
        
        var body: some View {
            Stats()
                .environmentObject(model)
        }
    }
    static var previews: some View {
        Preview()
    }
}
