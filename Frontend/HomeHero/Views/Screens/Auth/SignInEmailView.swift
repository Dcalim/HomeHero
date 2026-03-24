//
//  SignInEmailView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
import ComposableArchitecture

struct SignInEmailView: View {
    let store: StoreOf<AppFeature>

    @State private var email = ""
    @State private var password = ""
    @State private var hasAttemptedSubmit = false

    @Environment(\.dismiss) private var dismiss

    // MARK: - Validation

    private var emailError: String? {
        guard hasAttemptedSubmit || !email.isEmpty else { return nil }
        if email.isEmpty { return "Email is required" }
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        if !NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email) {
            return "Please enter a valid email address"
        }
        return nil
    }

    private var passwordError: String? {
        guard hasAttemptedSubmit || !password.isEmpty else { return nil }
        if password.isEmpty { return "Password is required" }
        if password.count < 6 { return "Password must be at least 6 characters" }
        return nil
    }

    private var isFormValid: Bool {
        !email.isEmpty && emailError == nil && password.count >= 6
    }

    // MARK: - Body

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: Theme.Layout.verticalSpacing) {
                Spacer().frame(height: 40)

                if let errorMessage = store.auth.errorMessage {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(Theme.error)
                        Text(errorMessage)
                            .font(Theme.Fonts.caption)
                            .foregroundColor(Theme.error)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Theme.error.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                HHTextField(
                    placeholder: "Email address",
                    text: $email,
                    icon: "envelope",
                    keyboardType: .emailAddress,
                    errorMessage: emailError
                )

                HHSecureField(
                    placeholder: "Password",
                    text: $password,
                    errorMessage: passwordError
                )

                HHButton(
                    title: "Sign In",
                    isDisabled: !isFormValid
                ) {
                    hasAttemptedSubmit = true
                    guard isFormValid else { return }
                    store.send(.auth(.signInButtonTapped(
                        email: email,
                        password: password
                    )))
                }

                NavigationLink {
                    SignUpEmailView(store: store)
                } label: {
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .foregroundColor(Theme.textTertiary)
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(Theme.accent)
                    }
                    .font(Theme.Fonts.body)
                }

                Spacer()
            }
            .padding(.horizontal, Theme.Layout.horizontalPadding)
        }
        .background(Theme.background.ignoresSafeArea())
        .navigationTitle("Sign In")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SignInEmailView(store: HomeHeroApp.store)
    }
}
