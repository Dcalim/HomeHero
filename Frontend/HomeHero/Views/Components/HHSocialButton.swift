//
//  HHSocialButton.swift
//  HomeHero
//

import SwiftUI

struct HHSocialButton: View {
    let provider: Provider
    let action: () -> Void

    enum Provider {
        case apple, google

        var title: String {
            switch self {
            case .apple:  return "Continue with Apple"
            case .google: return "Continue with Google"
            }
        }

        var icon: String {
            switch self {
            case .apple:  return "apple.logo"
            case .google: return "g.circle.fill"
            }
        }

        var iconColor: Color {
            switch self {
            case .apple:  return Color(light: .black, dark: .white)
            case .google: return Color(hex: "DB4437")
            }
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: provider.icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(provider.iconColor)
                    .frame(width: 24)

                Text(provider.title)
                    .font(Theme.Fonts.callout)
                    .foregroundColor(Theme.textPrimary)
            }
            .frame(height: Theme.Layout.buttonHeight)
            .frame(maxWidth: .infinity)
            .background(Theme.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: Theme.Layout.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Layout.cornerRadius)
                    .stroke(Theme.inputBorder, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview("Light") {
    VStack(spacing: 12) {
        HHSocialButton(provider: .apple) {}
        HHSocialButton(provider: .google) {}
    }
    .padding()
    .background(Theme.background)
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack(spacing: 12) {
        HHSocialButton(provider: .apple) {}
        HHSocialButton(provider: .google) {}
    }
    .padding()
    .background(Theme.background)
    .preferredColorScheme(.dark)
}
