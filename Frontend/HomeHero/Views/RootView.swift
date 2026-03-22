//
//  RootView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-26.
//

import SwiftUI
import ComposableArchitecture

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<AppFeature>

    var body: some View {
        WithViewStore(store, observe: \.auth.isSignedIn) { viewStore in
            ZStack {
                ContentView(store: store)
            }
            .fullScreenCover(
                isPresented: .constant(!viewStore.state)
            ) {
                NavigationStack {
                    AuthView(store: store)
                }
            }
//            .onAppear {
//                store.send(.auth(.checkAuthentication))
//            }
        }
    }
}

