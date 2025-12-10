//
//  HomeHeroApp.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-24.
//

import SwiftUI
import SwiftData

@main
struct HomeHeroApp: App {
    
    @StateObject private var store = Store(appState: AppState(), reducer: Reducer())
    @State private var authManager = AuthenticationManager.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                            .environmentObject(store) // inject store for entire app
                            .task { store.loadConfig() }      // run on launch
                            .onReceive(authManager.$authToken) { _ in
                                Task { store.loadConfig() }     // whenever token changes
                            }
            
        }
    }
}
