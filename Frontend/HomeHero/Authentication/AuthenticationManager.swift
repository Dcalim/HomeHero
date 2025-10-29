//
//  AuthenticationManager.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-25.
//

import Foundation
import Supabase

struct appUser {
    let uid: String
    let email: String?
    
    init(session: Session){
        self.uid = session.user.id.uuidString
        self.email = session.user.email
       
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init () {}
    
    let client = SupabaseClient(
      supabaseURL: URL(string: "https://ycagpnrdvljcjretnwyp.supabase.co")!,
      supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InljYWdwbnJkdmxqY2pyZXRud3lwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE2ODEzODQsImV4cCI6MjA3NzI1NzM4NH0.Lo9pdXo9la373GMEXFwveAu3_YaDWYM0tx3m8ea1kS0"
    )
    
    func getAuthenticatedUser () async throws -> appUser{
        let session = try await client.auth.session
        print(session)
        return appUser(session: session)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> appUser {
        let response = try await client.auth.signUp(email: email, password: password)
        guard let session = response.session else {
            print("no session")
            throw NSError()
        }
        return appUser(session: session)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> appUser {
        let session = try await client.auth.signIn(email: email, password: password)
        return appUser(session: session)
    }
    
    func logout() async throws {
        try await client.auth.signOut()
    }
    
}
