//
//  HomeView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<AppFeature>

    var body: some View {
        HHHomePickerPage(store: store) {
            Text("Welcome,")
                .font(Theme.Fonts.title3)
                .foregroundColor(Theme.textSecondary)

            Text(store.profileFeature.data.firstName)
                .font(Theme.Fonts.largeTitle)
                .foregroundColor(Theme.textPrimary)

            Text("Home")
                .font(Theme.Fonts.caption)
                .foregroundColor(Theme.textTertiary)
                .textCase(.uppercase)
                .tracking(1.2)

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(store: HomeHeroApp.store)
    }
}
