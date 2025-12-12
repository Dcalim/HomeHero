////
////  store.swift
////  HomeHero
////
////  Created by Dion Calim on 2025-11-30.
////
import Foundation
import SwiftUI  // Needed for ObservableObject and @Published
internal import Combine

struct AppState {
    var counter = 100
    var config = ConfigState()
}


enum Action {
    case increment
    
    case config(ConfigAction)
}

class Reducer {
    private let configReducer = ConfigReducer()
    
    func update(_ appState: inout AppState, _ action: Action) {
        switch action {
        
        case .increment:
            appState.counter += 1
        
        case .config(let configAction):
            configReducer.reduce(&appState.config, configAction)
        }
    }
}

class Store: ObservableObject {
    
    @Published var appState: AppState
    private let reducer: Reducer
    
    init(appState: AppState, reducer: Reducer) {
        self.appState = appState
        self.reducer = reducer
    }
    
    func dispatch(_ action: Action) {
        reducer.update(&appState, action)
    }
    
    // MARK: - THUNK
    func loadConfig() {
        dispatch(.config(.loadConfig))
        
        Task {
            do {
                let config = try await ConfigManager.shared.loadConfig()
                print("Config: \(config)")
                await MainActor.run {
                    self.dispatch(.config(.loadConfigSuccess(config)))
                }
            } catch {
                await MainActor.run {
                    print("error occurred")
                    self.dispatch(.config(.loadConfigFailure(error.localizedDescription)))
                }
            }
        }
    }
}
