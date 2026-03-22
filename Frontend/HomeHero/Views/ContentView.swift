//
//  ContentView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-24.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<AppFeature>

    var body: some View {
        WithViewStore(store, observe: \.ui) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: \.tab,
                    send: { .ui(.tabSelected($0))}
                )
            ) {
                // HOME
                NavigationStack {
                    HomeView(store: store)
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(UIFeature.Tabs.home)

                // TASKS
                NavigationStack {
                    TasksView(store: store)
                }
                .tabItem {
                    Label("Tasks", systemImage: "checkmark.circle")
                }
                .tag(UIFeature.Tabs.tasks)

                // EXPENSES
                NavigationStack {
                    ExpensesView(store: store)
                }
                .tabItem {
                    Label("Expenses", systemImage: "dollarsign.circle.fill")
                }
                .tag(UIFeature.Tabs.expenses)
                
                // SETTINGS
                NavigationStack {
                    SettingsView(store: store)
                }
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(UIFeature.Tabs.settings)
            }
            .onOpenURL { url in
                if url.host() == "tab" {
                    let tab: UIFeature.Tabs?
                    switch url.lastPathComponent.lowercased() {
                    case "home": tab = .home
                    case "tasks": tab = .tasks
                    case "expenses": tab = .expenses
                    case "settings": tab = .settings
                    default: tab = nil
                    }
                    
                    if let tab {
                        viewStore.send(.ui(.tabSelected(tab)))
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(
        store: Store(
            initialState: AppFeature.State(),
            reducer: { AppFeature() }
        )
    )
}
