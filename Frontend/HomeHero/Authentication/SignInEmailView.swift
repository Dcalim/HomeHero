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

    var body: some View {
        WithViewStore(store, observe: \.auth) { viewStore in
            VStack {
                Spacer()

                if let errorMessage = viewStore.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                }

                TextField("Email...", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)

                SecureField("Password...", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)

                Button {
                    viewStore.send(.auth(.signInButtonTapped(
                        email: email,
                        password: password
                    ))
                    )
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .cornerRadius(10)
                }
                
                NavigationLink {
                    SignUpEmailView(store: store)
                } label: {
                    Text("Don't have an account? Sign Up!")
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Sign In")
        }
    }
}

