//
//  HHButton.swift
//  HomeHero
//

import SwiftUI

struct HHButton: View {
    let title: String
    var isLoading: Bool = false
    var isDisabled: Bool = false
    var variant: Variant = .primary
    let action: () -> Void

    enum Variant {
        case primary, secondary, outline
    }

    private var backgroundColor: Color {
        switch variant {
        case .primary:   return Theme.primary
        case .secondary: return Theme.secondary
        case .outline:   return .clear
        }
    }

    private var foregroundColor: Color {
        switch variant {
        case .primary, .secondary: return .white
        case .outline:             return Theme.accent
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .tint(foregroundColor)
                } else {
                    Text(title)
                        .font(Theme.Fonts.headline)
                }
            }
            .foregroundColor(foregroundColor)
            .frame(height: Theme.Layout.buttonHeight)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: Theme.Layout.cornerRadius))
            .overlay(
                Group {
                    if variant == .outline {
                        RoundedRectangle(cornerRadius: Theme.Layout.cornerRadius)
                            .stroke(Theme.accent.opacity(0.5), lineWidth: 1.5)
                    }
                }
            )
            .shadow(
                color: variant != .outline ? Theme.primary.opacity(0.35) : .clear,
                radius: Theme.Layout.shadowRadius,
                y: Theme.Layout.shadowY
            )
        }
        .disabled(isDisabled || isLoading)
        .opacity(isDisabled ? 0.4 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isDisabled)
    }
}

#Preview {
    VStack(spacing: 16) {
        HHButton(title: "Sign In") {}
        HHButton(title: "Sign In", isDisabled: true) {}
        HHButton(title: "Loading…", isLoading: true) {}
        HHButton(title: "Outline", variant: .outline) {}
    }
    .padding()
    .background(Theme.background)
}
