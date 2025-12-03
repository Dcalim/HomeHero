//
//  resetPasswordView.swift
//  HomeHero
//
//  Created by Antonio Conopio on 2025-12-01.
//

import SwiftUI
import ComponentsKit
internal import Combine

@MainActor
final class resetPasswordViewModel: ObservableObject {
    
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var verifyPassword = ""
    @Published var nonce = ""
    @Published var errorMessage = ""
    
    func resetPassword() async throws{
        try await AuthenticationManager.shared.changePassword(newPassword: newPassword, nonce: nonce)
    }
    
    func reAuth() async throws{
        try await AuthenticationManager.shared.reAuthenticate()
    }
    
    func validate() {
        if self.oldPassword.isEmpty || self.newPassword.isEmpty || self.verifyPassword.isEmpty {
            errorMessage = "Please fill in all fields"
        } else if self.newPassword != self.verifyPassword {
            errorMessage = "Passwords do not match"
        }
        else {
            errorMessage = ""
        }
    }
   
}

struct resetPasswordView: View {
    
    @Binding var showResetPassword: Bool
    
    @State var isModalPresented = false
    @StateObject private var viewModel = resetPasswordViewModel()
    
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    withAnimation(.spring()) {
                        showResetPassword = false
                    }
                    
                }) {
                    Image(systemName: "chevron.down")
                }
                Spacer()
                
            }
            
            Spacer()
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .transition(.opacity)
            }
            
            SecureField("Password", text: $viewModel.oldPassword)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("New Password", text: $viewModel.newPassword)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Repeat Password", text: $viewModel.verifyPassword)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button(action: {
                Task{
                    do {
                        viewModel.validate()
                        if (viewModel.errorMessage.isEmpty) {
                            try await viewModel.reAuth()
                            isModalPresented = true
                        }
                    } catch {
                        print(error)
                    }
                }
                
            }) {
                Text("Change Password")
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
            .centerModal(
                isPresented: $isModalPresented,
                onDismiss: {
                  print("Modal dismissed")
                },
                header: {
                  Text("Check your email!")
                },
                body: {
                    TextField("Code", text: $viewModel.nonce)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                },
                footer: {
                    Button(action:{
                        Task{
                            do{
                                try await viewModel.resetPassword()
                            }catch{
                                print(error)
                            }
                        }
                    })
                    {
                        Text("Submit")
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
                }
              )
            
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    resetPasswordView(showResetPassword: .constant(true))
}
