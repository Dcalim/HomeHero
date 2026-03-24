//
//  AuthView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
import ComposableArchitecture

struct AuthView: View {
    let store: StoreOf<AppFeature>

    @State private var email = ""
    @State private var password = ""
    @State private var hasAttemptedSubmit = false
    @State private var showForgotPassword = false
    @State private var animateContent = false

    // MARK: - Validation

    private var emailError: String? {
        guard hasAttemptedSubmit || !email.isEmpty else { return nil }
        if email.isEmpty { return "Email is required" }
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        if !predicate.evaluate(with: email) {
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
        let emailOK = !email.isEmpty && emailError == nil
        let passOK  = !password.isEmpty && passwordError == nil
        return emailOK && passOK
    }

    // MARK: - Body

    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // MARK: Hero

                    heroSection
                        .padding(.top, 40)
                        .padding(.bottom, 36)

                    // MARK: Form

                    VStack(spacing: Theme.Layout.verticalSpacing) {
                        errorBanner

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

                        forgotPasswordLink

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
                        .padding(.top, 4)
                    }
                    .padding(.horizontal, Theme.Layout.horizontalPadding)

                    // MARK: Divider

                    orDivider
                        .padding(.vertical, 28)

                    // MARK: Social Login

                    VStack(spacing: 12) {
                        HHSocialButton(provider: .apple) {
                            // TODO: Apple Sign In integration
                        }

                        HHSocialButton(provider: .google) {
                            // TODO: Google Sign In integration
                        }
                    }
                    .padding(.horizontal, Theme.Layout.horizontalPadding)

                    // MARK: Sign Up Link

                    signUpLink
                        .padding(.top, 32)
                        .padding(.bottom, 32)
                }
            }
            .background(Theme.background.ignoresSafeArea())
            .navigationBarHidden(true)
            .sheet(isPresented: $showForgotPassword) {
                ForgotPasswordSheet()
            }
            .opacity(animateContent ? 1 : 0)
            .offset(y: animateContent ? 0 : 16)
            .onAppear {
                withAnimation(.easeOut(duration: 0.5).delay(0.1)) {
                    animateContent = true
                }
            }
            
            // 🔥 Spinner Overlay
            if store.auth.isLoading || store.config.isLoading {
                Color.black.opacity(0.3)          // semi-transparent background
                    .ignoresSafeArea()
                
                ProgressView()                     // spinning indicator
                    .scaleEffect(1.5)             // make it bigger
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        }
        
    }

    // MARK: - Sub-views

    private var heroSection: some View {
        VStack(spacing: 8) {
            Image(systemName: "house.fill")
                .font(.system(size: 52))
                .foregroundStyle(Theme.primaryGradient)
                .shadow(color: Theme.skyBlue.opacity(0.3), radius: 16, y: 0)
                .padding(.bottom, 4)

            Text("HomeHero")
                .font(Theme.Fonts.largeTitle)
                .foregroundColor(Theme.textPrimary)

            Text("Welcome back! Sign in to continue.")
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

    private var forgotPasswordLink: some View {
        HStack {
            Spacer()
            Button {
                showForgotPassword = true
            } label: {
                Text("Forgot Password?")
                    .font(Theme.Fonts.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Theme.accent)
            }
        }
        .padding(.top, -4)
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

    private var signUpLink: some View {
        HStack(spacing: 4) {
            Text("Don't have an account?")
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.textTertiary)

            NavigationLink {
                SignUpEmailView(store: store)
            } label: {
                Text("Sign Up")
                    .font(Theme.Fonts.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Theme.accent)
            }
        }
    }
}

// MARK: - Forgot Password Sheet

struct ForgotPasswordSheet: View {
    @State private var email = ""
    @State private var submitted = false
    @Environment(\.dismiss) private var dismiss

    private var isEmailValid: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                if submitted {
                    submittedContent
                } else {
                    formContent
                }
                Spacer()
            }
            .padding(.horizontal, Theme.Layout.horizontalPadding)
            .padding(.top, 24)
            .background(Theme.background.ignoresSafeArea())
            .navigationTitle("Reset Password")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(Theme.accent)
                }
            }
        }
    }

    private var formContent: some View {
        VStack(spacing: 20) {
            Text("Enter your email address and we'll send you a link to reset your password.")
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.textTertiary)
                .multilineTextAlignment(.center)

            HHTextField(
                placeholder: "Email address",
                text: $email,
                icon: "envelope",
                keyboardType: .emailAddress
            )

            HHButton(
                title: "Send Reset Link",
                isDisabled: !isEmailValid
            ) {
                withAnimation { submitted = true }
            }
        }
    }

    private var submittedContent: some View {
        VStack(spacing: 16) {
            Image(systemName: "paperplane.fill")
                .font(.system(size: 44))
                .foregroundStyle(Theme.primaryGradient)
                .shadow(color: Theme.skyBlue.opacity(0.3), radius: 12, y: 0)

            Text("Check your inbox")
                .font(Theme.Fonts.title)
                .foregroundColor(Theme.textPrimary)

            Text("We've sent a password reset link to **\(email)**.")
                .font(Theme.Fonts.body)
                .foregroundColor(Theme.textTertiary)
                .multilineTextAlignment(.center)

            HHButton(title: "Done") { dismiss() }
                .padding(.top, 8)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        AuthView(store: HomeHeroApp.store)
    }
}
