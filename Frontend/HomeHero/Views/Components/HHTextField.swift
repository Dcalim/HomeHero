//
//  HHTextField.swift
//  HomeHero
//

import SwiftUI

struct HHTextField: View {
    let placeholder: String
    @Binding var text: String
    var icon: String? = nil
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .never
    var errorMessage: String? = nil

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
                if let icon {
                    Image(systemName: icon)
                        .foregroundColor(isFocused ? Theme.accent : Theme.textTertiary)
                        .frame(width: 20)
                }

                TextField(placeholder, text: $text)
                    .font(Theme.Fonts.body)
                    .foregroundColor(Theme.textPrimary)
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(autocapitalization)
                    .autocorrectionDisabled()
                    .focused($isFocused)
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
        HHTextField(
            placeholder: "Email address",
            text: .constant(""),
            icon: "envelope",
            keyboardType: .emailAddress
        )
        HHTextField(
            placeholder: "Email address",
            text: .constant("bad-email"),
            icon: "envelope",
            errorMessage: "Please enter a valid email"
        )
    }
    .padding()
    .background(Theme.background)
}
