//
//  SettingsView.swift
//  Cards
//
//  Created by Armin on 7/23/23.
//

import SwiftUI
import SymbolPicker

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var presentedSheet: SheetSection?
    
    @AppStorage("leftOptionIcon") var leftOptionIcon: String = "hand.thumbsdown.circle"
    @AppStorage("leftOptionTitle") var leftOptionTitle: String = "Forgotten"
    
    @AppStorage("rightOptionIcon") var rightOptionIcon: String = "hand.thumbsup.circle"
    @AppStorage("rightOptionTitle") var rightOptionTitle: String = "Known"
    
    enum SheetSection: String, Identifiable {
        case left, right
        
        var id: String { rawValue }
    }
    
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
            Section("Right Section") {
                HStack {
                    Button {
                        presentedSheet = .right
                    } label: {
                        Image(systemName: rightOptionIcon)
                            .font(.title)
                            .frame(alignment: .center)
                    }
                    #if os(iOS)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(radius: 0.5)
                    #endif
                    
                    TextField("Right section title", text: $rightOptionTitle)
                }
            }
            #if os(iOS)
            .listRowBackground(Color("BackgroundSecondColor"))
            #endif
            
            Section("Left Section") {
                HStack {
                    Button {
                        presentedSheet = .left
                    } label: {
                        Image(systemName: leftOptionIcon)
                            .font(.title)
                            .frame(alignment: .center)
                    }
                    #if os(iOS)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(radius: 0.5)
                    #endif
                    
                    TextField("Left section title", text: $leftOptionTitle)
                }
            }
            #if os(iOS)
            .listRowBackground(Color("BackgroundSecondColor"))
            #endif
        }
        #if os(iOS)
        .scrollContentBackground(.hidden)
        #endif
        .navigationTitle("Card swiping")
        .toolbar {
            ToolbarItem {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Label("Close", systemImage: "xmark.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                }

            }
        }
        .sheet(item: $presentedSheet) { sheet in
            switch sheet {
            case .left:
                SymbolPicker(symbol: $leftOptionIcon)
            case .right:
                SymbolPicker(symbol: $rightOptionIcon)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
