//
//  ContentView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-24.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

enum AppTab: Hashable {
    case home, tasks, expenses, settings
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .tasks: return "Tasks"
        case .expenses: return "Expenses"
        case .settings: return "Settings"
        }
    }
    
    var systemImage: String {
        switch self {
        case .home: return "house.fill"
        case .tasks: return "checkmark.circle"
        case .expenses: return "dollarsign.circle.fill"
        case .settings: return "gearshape.fill"
        }
    }
}

struct ContentView: View {
    let store: StoreOf<AppFeature>
    
    @State private var selected: AppTab = .home
    @Binding var showSignedInView: Bool
    
    var body: some View {
        TabView(selection: $selected) {
            NavigationStack {
                HomeView(store: store)
//                    .environmentObject(store)
            }
            .tabItem {
                Label(AppTab.home.title, systemImage: AppTab.home.systemImage)
            }
            .tag(AppTab.home)
            
            NavigationStack {
                TasksView()
//                    .environmentObject(store)
            }
            .tabItem {
                Label(AppTab.tasks.title, systemImage: AppTab.tasks.systemImage)
            }
            .tag(AppTab.tasks)
            
    
            NavigationStack {
//                ExpensesView()
//                    .environmentObject(store)
            }
            .tabItem {
                Label(AppTab.expenses.title, systemImage: AppTab.expenses.systemImage)
            }
            .tag(AppTab.expenses)
            
            NavigationStack {
                SettingsView(showSignedInView: $showSignedInView)
//                    .environmentObject(store)
            }
            .tabItem {
                Label(AppTab.settings.title, systemImage: AppTab.settings.systemImage)
            }
            .tag(AppTab.settings)
        }
        .onOpenURL { url in
            // Example deep link: myapp://tab/tasks
            if url.host() == "tab" {
                switch url.lastPathComponent.lowercased() {
                case "home": selected = .home
                case "tasks": selected = .tasks
                case "expenses": selected = .expenses
                case "settings": selected = .settings
                default: break
                }
            }
        }
    }
}


#Preview {
    ContentView(store: HomeHeroApp.store, showSignedInView: .constant(true))
}
