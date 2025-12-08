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
}

enum Action {
    case increment
}

class Reducer {
    func update(_ appState: inout AppState, _ action: Action) {
        switch action {
        case .increment:
            appState.counter += 1
        }
    }
}

class Store: ObservableObject {
    
    var reducer: Reducer
    @Published var appState: AppState

    init(appState: AppState, reducer: Reducer) {
        self.appState = appState
        self.reducer = reducer
    }
    
    func dispatch(_ action: Action) {
        self.reducer.update(&appState, action)
    }
}
