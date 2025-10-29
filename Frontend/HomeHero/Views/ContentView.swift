//
//  ContentView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-24.
//

import SwiftUI
import SwiftData

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
    @State private var selected: AppTab = .home
    @Binding var showSignedInView: Bool
    
    var body: some View {
        TabView(selection: $selected) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label(AppTab.home.title, systemImage: AppTab.home.systemImage)
            }
            .tag(AppTab.home)
            
            NavigationStack {
                TasksView()
            }
            .tabItem {
                Label(AppTab.tasks.title, systemImage: AppTab.tasks.systemImage)
            }
            .tag(AppTab.tasks)
            
    
            NavigationStack {
                ExpensesView()
            }
            .tabItem {
                Label(AppTab.expenses.title, systemImage: AppTab.expenses.systemImage)
            }
            .tag(AppTab.expenses)
            
            NavigationStack {
                SettingsView(showSignedInView: $showSignedInView)
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
    ContentView(showSignedInView: .constant(true))
}
