//
//  SettingsView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
internal import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func logout() async throws {
        try await AuthenticationManager.shared.logout()
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignedInView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try await viewModel.logout()
                        showSignedInView = true
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignedInView: .constant(false))
    }
}
