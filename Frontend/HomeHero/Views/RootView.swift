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

    var body: some View {
            ZStack {
                ContentView(store: store)
            }
            .fullScreenCover(
                isPresented: .constant(!store.auth.isSignedIn)
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

