//
//  UIFeature.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-23.
//

import ComposableArchitecture
import Foundation

@Reducer
struct UIFeature {

    enum Tabs: String {
        case home = "home"
        case tasks = "tasks"
        case expenses = "expenses"
        case settings = "settings"
    }

    @ObservableState
    struct State: Equatable {
        var tab: Tabs = .home
        var isLoading = false
        var error: String?
    }

    enum Action {
        case tabSelected(Tabs)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tabSelected(let tab):
                state.tab = tab
                return .none
            }
        }
    }
}
