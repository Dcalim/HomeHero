//
//  SignInEmailView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
internal import Combine

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}

struct SignInEmailView: View {
    
    @Binding var showSignedInView: Bool
    @StateObject private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        VStack{
                
            
            Spacer()
            
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button(action: {
                Task{
                    do{
                        try await viewModel.signIn()
                        showSignedInView = false
                    }catch{
                        print(error)
                    }
                }
            }) {
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
            
            NavigationLink{
                SignUpEmailView(showSignedInView: $showSignedInView)
            }label:{
                Text("Don't have an account? Sign Up!")
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
       
    }
}

#Preview {
    NavigationView{
        SignInEmailView(showSignedInView: .constant(true))
    }
}
