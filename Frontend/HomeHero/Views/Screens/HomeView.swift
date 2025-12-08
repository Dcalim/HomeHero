//
//  HomeView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI

struct HomeView: View {


    @EnvironmentObject var store: Store  // <-- Inject the store here

    var body: some View {
        VStack {
            let _ = print("Token: \(getToken() ?? "NONE")")

            Text("Hello, World!")

            Text("\(store.appState.counter)")
                .padding()

            Button("Increment") {
                store.dispatch(.increment)

                Task {
                    do {
                        let configData = try await ApiService.shared.config()
                        print("Config response: \(configData)")
                        print("First Name: \(configData.profile.firstName)")
                    } catch {
                        print("Config error: \(error)")
                    }
                }
            }
        }
        .padding()
        .onAppear {
            print("Counter at start: \(store.appState.counter)")
            print("Token: \(getToken() ?? "NONE")")
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Store(appState: AppState(), reducer: Reducer())) // Provide a store for preview
}
