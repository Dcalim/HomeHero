//
//  SignInEmailView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
internal import Combine
import ComposableArchitecture

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var phone = ""
    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        try await AuthenticationManager.shared.createUser(
            email: email,
            password: password,
            firstname: firstname,
            lastname: lastname,
            phone: phone)

    }
}

struct SignUpEmailView: View {
    let store: StoreOf<AppFeature>

    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phone = ""

    var body: some View {
        WithViewStore(store, observe: \.auth) { viewStore in
            VStack {
                Spacer()

                if let error = viewStore.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                }

                HStack {
                    TextField("First name...", text: $firstName)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                        .autocorrectionDisabled(true)
                    
                    TextField("Last Name...", text: $lastName)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                        .autocorrectionDisabled(true)
                }

                TextField("Email...", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                
                TextField("Phone number...", text: $phone)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.phonePad)
                
                SecureField("Password...", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)

                Button {
                    viewStore.send(.auth(.signUpButtonTapped(
                        email: email,
                        password: password,
                        firstName: firstName,
                        lastName: lastName,
                        phone: phone
                    ))
                    )
                } label: {
                    Text("Sign up")
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

                Spacer()
            }
            .padding()
            .navigationTitle("Sign Up")
        }
    }
}


#Preview {
    NavigationView{
        SignUpEmailView(store: HomeHeroApp.store)
    }
}
