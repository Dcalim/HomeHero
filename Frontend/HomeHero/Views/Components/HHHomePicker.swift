//
//  HHHomePicker.swift
//  HomeHero
//

import SwiftUI
import ComposableArchitecture

// MARK: - Page container (scrim + picker + page content)

/// Wraps page content in a ZStack that layers: content → dim scrim → home picker.
/// Use this on any screen that needs the household dropdown at the top.
struct HHHomePickerPage<Content: View>: View {
    let store: StoreOf<AppFeature>
    @ViewBuilder let content: () -> Content
    @State private var pickerExpanded = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 12) {
                Color.clear.frame(height: 44)
                content()
            }
            .padding(.horizontal, Theme.Layout.horizontalPadding)
            .padding(.top, 16)
            .frame(maxWidth: .infinity, alignment: .leading)

            if pickerExpanded {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            pickerExpanded = false
                        }
                    }
                    .transition(.opacity)
            }

            HHHomePicker(store: store, isExpanded: $pickerExpanded)
                .padding(.horizontal, Theme.Layout.horizontalPadding)
                .padding(.top, 16)
        }
        .background(Theme.background.ignoresSafeArea())
        .animation(.easeInOut(duration: 0.25), value: pickerExpanded)
    }
}

// MARK: - Picker (trigger + overlay dropdown)

struct HHHomePicker: View {
    let store: StoreOf<AppFeature>
    @Binding var isExpanded: Bool

    private var selectedHome: Home? { store.homesFeature.selectedHome }
    private var homes: [Home] { store.homesFeature.data }

    var body: some View {
        trigger
            .overlay(alignment: .topLeading) {
                if isExpanded {
                    dropdown
                        .frame(width: 280)
                        .offset(y: 48)
                }
            }
            .zIndex(100)
    }

    // MARK: - Trigger (compact pill)

    private var trigger: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                isExpanded.toggle()
            }
        } label: {
            HStack(spacing: 6) {
                Text(selectedHome?.name ?? "No Home")
                    .font(Theme.Fonts.headline)
                    .foregroundColor(Theme.textPrimary)

                Image(systemName: "chevron.down")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(Theme.textTertiary)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Theme.cardBackground)
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    // MARK: - Dropdown card

    private var dropdown: some View {
        VStack(alignment: .leading, spacing: 0) {
            homesList

            if !homes.isEmpty {
                divider
            }

            actionRows
        }
        .padding(.vertical, 12)
        .background(Theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.25), radius: 20, y: 8)
        .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .topLeading)))
    }

    // MARK: - Homes list

    private var homesList: some View {
        ForEach(Array(homes.enumerated()), id: \.element.id) { index, home in
            let isSelected = home == selectedHome

            Button {
                store.send(.homesFeature(.selectHome(home)))
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded = false
                }
            } label: {
                HStack(spacing: 14) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 22))
                        .foregroundColor(isSelected ? Theme.accent : Theme.textTertiary)
                        .frame(width: 32, height: 32)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(home.name)
                            .font(Theme.Fonts.callout)
                            .foregroundColor(Theme.textPrimary)
                    }

                    Spacer()

                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }

    // MARK: - Action rows

    private var actionRows: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                store.send(.homesFeature(.addHome))
            } label: {
                HStack(spacing: 14) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(Theme.accent)
                        .frame(width: 32, height: 32)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Add Household")
                            .font(Theme.Fonts.callout)
                            .foregroundColor(Theme.textPrimary)

                        Text("Create or join a home")
                            .font(Theme.Fonts.caption)
                            .foregroundColor(Theme.textTertiary)
                    }

                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button {
                store.send(.homesFeature(.leaveHome))
            } label: {
                HStack(spacing: 14) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(Theme.error)
                        .frame(width: 32, height: 32)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Leave Household")
                            .font(Theme.Fonts.callout)
                            .foregroundColor(Theme.textPrimary)

                        Text("Leave the current home")
                            .font(Theme.Fonts.caption)
                            .foregroundColor(Theme.textTertiary)
                    }

                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .opacity(selectedHome != nil ? 1 : 0.4)
            .disabled(selectedHome == nil)
        }
    }

    // MARK: - Divider

    private var divider: some View {
        Rectangle()
            .fill(Theme.dividerColor)
            .frame(height: 1)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
    }
}

#Preview("With Homes") {
    HHHomePickerPage(store: HomeHeroApp.store) {
        Text("Welcome,")
            .font(Theme.Fonts.title3)
        Text("Preview")
            .font(Theme.Fonts.largeTitle)
        Spacer()
    }
}
