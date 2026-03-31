//
//  SettingsView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
import ComposableArchitecture

struct SettingsView: View {
    let store: StoreOf<AppFeature>

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Welcome,")
                .font(Theme.Fonts.title3)
                .foregroundColor(Theme.textSecondary)

            Text(store.profileFeature.data.firstName)
                .font(Theme.Fonts.largeTitle)
                .foregroundColor(Theme.textPrimary)

            Text("Settings")
                .font(Theme.Fonts.caption)
                .foregroundColor(Theme.textTertiary)
                .textCase(.uppercase)
                .tracking(1.2)

            Spacer()

            Button {
                store.send(.auth(.signOut))
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Log Out")
                        .font(Theme.Fonts.headline)
                }
                .foregroundColor(Theme.error)
                .frame(height: Theme.Layout.buttonHeight)
                .frame(maxWidth: .infinity)
                .background(Theme.error.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: Theme.Layout.cornerRadius))
            }
            .padding(.bottom, 24)
        }
        .padding(.horizontal, Theme.Layout.horizontalPadding)
        .padding(.top, 32)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.background.ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        SettingsView(store: HomeHeroApp.store)
    }
}
