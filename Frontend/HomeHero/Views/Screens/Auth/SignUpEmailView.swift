//
//  SignUpEmailView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
import ComposableArchitecture

struct SignUpEmailView: View {
    let store: StoreOf<AppFeature>

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var hasAttemptedSubmit = false
    @State private var animateContent = false

    @Environment(\.dismiss) private var dismiss

    // MARK: - Validation

    private var firstNameError: String? {
        guard hasAttemptedSubmit else { return nil }
        if firstName.trimmingCharacters(in: .whitespaces).isEmpty {
            return "First name is required"
        }
        return nil
    }

    private var lastNameError: String? {
        guard hasAttemptedSubmit else { return nil }
        if lastName.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Last name is required"
        }
        return nil
    }

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

    private var confirmPasswordError: String? {
        guard hasAttemptedSubmit || !confirmPassword.isEmpty else { return nil }
        if confirmPassword.isEmpty { return "Please confirm your password" }
        if confirmPassword != password { return "Passwords do not match" }
        return nil
    }

    private var isFormValid: Bool {
        let nameOK    = !firstName.trimmingCharacters(in: .whitespaces).isEmpty
                     && !lastName.trimmingCharacters(in: .whitespaces).isEmpty
        let emailOK   = !email.isEmpty && emailError == nil
        let passOK    = password.count >= 6
        let confirmOK = confirmPassword == password && !confirmPassword.isEmpty
        return nameOK && emailOK && passOK && confirmOK
    }

    // MARK: - Body

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {

                // MARK: Hero

                heroSection
                    .padding(.top, 24)
                    .padding(.bottom, 32)

                // MARK: Form

                VStack(spacing: Theme.Layout.verticalSpacing) {
                    errorBanner

                    HStack(spacing: 12) {
                        HHTextField(
                            placeholder: "First name",
                            text: $firstName,
                            icon: "person",
                            autocapitalization: .words,
                            errorMessage: firstNameError
                        )

                        HHTextField(
                            placeholder: "Last name",
                            text: $lastName,
                            autocapitalization: .words,
                            errorMessage: lastNameError
                        )
                    }

                    HHTextField(
                        placeholder: "Email address",
                        text: $email,
                        icon: "envelope",
                        keyboardType: .emailAddress,
                        errorMessage: emailError
                    )

                    HHTextField(
                        placeholder: "Phone number",
                        text: $phone,
                        icon: "phone",
                        keyboardType: .phonePad
                    )

                    HHSecureField(
                        placeholder: "Password",
                        text: $password,
                        errorMessage: passwordError
                    )

                    HHSecureField(
                        placeholder: "Confirm password",
                        text: $confirmPassword,
                        icon: "lock.fill",
                        errorMessage: confirmPasswordError
                    )

                    HHButton(
                        title: "Create Account",
                        isDisabled: !isFormValid
                    ) {
                        hasAttemptedSubmit = true
                        guard isFormValid else { return }
                        store.send(.auth(.signUpButtonTapped(
                            email: email,
                            password: password,
                            firstName: firstName,
                            lastName: lastName,
                            phone: phone
                        )))
                    }
                    .padding(.top, 4)
                }
                .padding(.horizontal, Theme.Layout.horizontalPadding)

                // MARK: Divider

                orDivider
                    .padding(.vertical, 28)

                // MARK: Social Sign Up

                VStack(spacing: 12) {
                    HHSocialButton(provider: .apple) {
                        // TODO: Apple Sign In integration
                    }

                    HHSocialButton(provider: .google) {
                        // TODO: Google Sign In integration
                    }
                }
                .padding(.horizontal, Theme.Layout.horizontalPadding)

                // MARK: Sign In Link

                signInLink
                    .padding(.top, 32)
                    .padding(.bottom, 32)
            }
        }
        .background(Theme.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Back")
                            .font(Theme.Fonts.body)
                    }
                    .foregroundColor(Theme.accent)
                }
            }
        }
        .opacity(animateContent ? 1 : 0)
        .offset(y: animateContent ? 0 : 16)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5).delay(0.1)) {
                animateContent = true
            }
        }
    }

    // MARK: - Sub-views

    private var heroSection: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.badge.plus")
                .font(.system(size: 44))
                .foregroundStyle(Theme.primaryGradient)
                .shadow(color: Theme.skyBlue.opacity(0.3), radius: 12, y: 0)
                .padding(.bottom, 4)

            Text("Create Account")
                .font(Theme.Fonts.title)
                .foregroundColor(Theme.textPrimary)

            Text("Join your household and start collaborating.")
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
        }
    }

    @ViewBuilder
    private var errorBanner: some View {
        if let errorMessage = store.auth.errorMessage {
            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(Theme.error)

                Text(errorMessage)
                    .font(Theme.Fonts.caption)
                    .foregroundColor(Theme.error)
                    .multilineTextAlignment(.leading)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Theme.error.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .transition(.opacity.combined(with: .move(edge: .top)))
        }
    }

    private var orDivider: some View {
        HStack(spacing: 16) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Theme.dividerColor)

            Text("OR")
                .font(Theme.Fonts.caption)
                .foregroundColor(Theme.textTertiary)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(Theme.dividerColor)
        }
        .padding(.horizontal, Theme.Layout.horizontalPadding)
    }

    private var signInLink: some View {
        HStack(spacing: 4) {
            Text("Already have an account?")
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.textTertiary)

            Button {
                dismiss()
            } label: {
                Text("Sign In")
                    .font(Theme.Fonts.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Theme.accent)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SignUpEmailView(store: HomeHeroApp.store)
    }
}
