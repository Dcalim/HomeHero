//
//  HomeHeroApp.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-24.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct HomeHeroApp: App {
    
    static let store = Store(initialState: AppFeature.State()) {
      AppFeature()
    }
    @State private var authManager = AuthenticationManager.shared
    
    var body: some Scene {
        WindowGroup {
            RootView(store: HomeHeroApp.store)
                .onReceive(authManager.$authToken) { _ in
                    HomeHeroApp.store.send(.config(.loadConfig))
                }
            
        }
    }
}
