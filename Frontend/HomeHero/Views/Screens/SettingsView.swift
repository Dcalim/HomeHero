//
//  SettingsView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import SwiftUI
import ComponentsKit
internal import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func logout() async throws {
        try await AuthenticationManager.shared.logout()
    }
}

struct SettingsView: View {
//    @EnvironmentObject var store: Store
//    
//    var profile: Profile {
//        store.selectProfile()
//    }
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignedInView: Bool
    @State private var showResetPassword = false
    @State private var displayName = ""
    
    var body: some View {
        ScrollView{
            VStack{
                HStack {
                    VStack (alignment: .leading){
                        Text("Settings")
                            .font(Font.largeTitle.bold())
                        Text("Manage your profile and home settings.")
                    }
                    .padding(.top, 25)
                    
                    Spacer()
                    
                }
                .padding(10)
            
            
                Spacer()
            
                // Profile Card
                SUCard(model: cardModel){
                    
                    VStack(alignment: .leading ){
                        Text("Profile")
                            .font(Font.title.bold())
                        
                        Text("Update your details and photo.")
                            .bold()
                            .foregroundStyle(Color(.gray))
                        
                        HStack{
                            
                            Button{
                                
                            } label: {
                                Image(systemName: "person.crop.circle")
                                    .font(Font.system(size: 50))
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            VStack (alignment: .leading){
                                Text("Full name")
//                                Text("\(profile.fullName)")
                                
                                Text("DISPLAY NAME")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                    .padding(.top, 5)
                                
                                TextField("Enter display name", text: $displayName)
                                    .padding()
                                    .background(Color(uiColor: .systemGray6))
                                    .cornerRadius(10)
                            }
                            
                        }
                        .padding(.vertical, 10)
                    }
                    .frame(width: .infinity)
                    
                    
                    
                    
                }
                
                SUCard(model: cardModel){
                    VStack(alignment: .leading ){
                        Text("Settings")
                            .font(Font.title.bold())
                        
                        Text("Control account, security, and household.")
                            .bold()
                            .foregroundStyle(Color(.gray))
                            .padding(.bottom, 10)
                        
                        Text("ACCOUNT")
                            .bold()
                            .foregroundStyle(Color(.gray))
                        
                        Button(action: {
                            
                        }) {
                            HStack{
                                Image(systemName: "person.crop.circle")
                                    .foregroundStyle(Color.black)
                                    .padding(.leading, 10)
                                Text("Manage Profile")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                    
                            }
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            withAnimation(.spring()) {
                                showResetPassword = true
                            }
                        }) {
                            HStack{
                                Image(systemName: "key.circle")
                                    .foregroundStyle(Color.black)
                                    .padding(.leading, 10)
                                Text("Change Password")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                    
                            }
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            
                        }) {
                            HStack{
                                Image(systemName: "bell.circle")
                                    .foregroundStyle(Color.black)
                                    .padding(.leading, 10)
                                Text("Notifications")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                    
                            }
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .cornerRadius(10)
                        }
                        
                        Text("HOME & SECURITY")
                            .bold()
                            .foregroundStyle(Color(.gray))
                        
                        Button(action: {
                            
                        }) {
                            HStack{
                                Image(systemName: "house.circle")
                                    .foregroundStyle(Color.black)
                                    .padding(.leading, 10)
                                Text("Household")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                    
                            }
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            
                        }) {
                            HStack{
                                Image(systemName: "shield")
                                    .foregroundStyle(Color.black)
                                    .padding(.leading, 10)
                                Text("Security")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                    
                            }
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                            .cornerRadius(10)
                        }
                        .sheet(isPresented: $showResetPassword){
                            resetPasswordView(showResetPassword: $showResetPassword)
                                .padding()
                        }
                        
                       
                        
                        Text("DANGER ZONE")
                            .bold()
                            .foregroundStyle(Color(.gray))
                        
                        Button(action: {
                            
                            Task {
                                do {
                                    try await viewModel.logout()
                                    showSignedInView = true
                                } catch {
                                    print(error)
                                }
                            }
                            
                        }) {
                            HStack{
                                
                                Text("Log out")
                                    .font(.headline)
                                    .foregroundColor(.red)
                                    .padding(.leading, 10)
                                Spacer()
                                    
                            }
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.1) )
                            
                            .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
        }
        .background(.clear)
    
    }
    

}

#Preview {
    NavigationStack {
        SettingsView(showSignedInView: .constant(false))
    }
}
