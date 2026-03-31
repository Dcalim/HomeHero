//
//  RootView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-26.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<AppFeature>

    private var currentScheme: ColorScheme {
        store.profileFeature.data.uiMode == .dark ? .dark : .light
    }

    var body: some View {
        ZStack {
                ContentView(store: store)
        }
        .fullScreenCover(
            isPresented: .constant(
                !store.auth.isSignedIn || store.auth.isLoading || store.profileFeature.isLoading
            )
        ) {
            NavigationStack {
                AuthView(store: store)
            }
            .preferredColorScheme(currentScheme)
        }
        .preferredColorScheme(currentScheme)
        
    }
}
