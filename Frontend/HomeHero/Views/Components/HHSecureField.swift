//
//  HHSecureField.swift
//  HomeHero
//

import SwiftUI

struct HHSecureField: View {
    let placeholder: String
    @Binding var text: String
    var icon: String = "lock"
    var errorMessage: String? = nil

    @State private var isRevealed = false
    @FocusState private var isFocused: Bool

    private var borderColor: Color {
        if errorMessage != nil && !text.isEmpty {
            return Theme.error
        }
        return isFocused ? Theme.accent : Theme.inputBorder
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(isFocused ? Theme.accent : Theme.textTertiary)
                    .frame(width: 20)

                Group {
                    if isRevealed {
                        TextField(placeholder, text: $text)
                    } else {
                        SecureField(placeholder, text: $text)
                    }
                }
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.textPrimary)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($isFocused)

                Button {
                    isRevealed.toggle()
                } label: {
                    Image(systemName: isRevealed ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(Theme.textTertiary)
                        .frame(width: 24)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .frame(height: Theme.Layout.inputHeight)
            .background(Theme.inputBackground)
            .clipShape(RoundedRectangle(cornerRadius: Theme.Layout.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Layout.cornerRadius)
                    .stroke(borderColor, lineWidth: isFocused ? 1.5 : 1)
            )
            .shadow(
                color: isFocused ? Theme.accent.opacity(0.2) : .clear,
                radius: 8, y: 0
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)

            if let errorMessage, !text.isEmpty {
                Text(errorMessage)
                    .font(Theme.Fonts.caption)
                    .foregroundColor(Theme.error)
                    .padding(.horizontal, 4)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: errorMessage)
    }
}

#Preview {
    VStack(spacing: 20) {
        HHSecureField(placeholder: "Password", text: .constant(""))
        HHSecureField(
            placeholder: "Password",
            text: .constant("abc"),
            errorMessage: "Must be at least 6 characters"
        )
    }
    .padding()
    .background(Theme.background)
}
