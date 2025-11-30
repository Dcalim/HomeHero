import Foundation
import Supabase

struct AppUser {
    let uid: String
    let email: String?

    init(session: Session) {
        self.uid = session.user.id.uuidString
        self.email = session.user.email
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init () {}
    
    let supabase = SupabaseClient(
        supabaseURL: URL(string: "https://ycagpnrdvljcjretnwyp.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InljYWdwbnJkdmxqY2pyZXRud3lwIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MTY4MTM4NCwiZXhwIjoyMDc3MjU3Mzg0fQ.hiJUmkVqmXmZ-qUIcMkJNJ2F5UBAL4V6OWxVNGTtis8"
    )
    
    func getAuthenticatedUser() async throws -> AppUser {
        let session = try await supabase.auth.session
        return AppUser(session: session)
    }
    
    @discardableResult
    func createUser(
        email: String,
        password: String,
        firstname: String,
        lastname: String,
        phone: String
    ) async throws -> AppUser {

        let response = try await supabase.auth.signUp(
            email: email,
            password: password,
            data: [
                "first_name": .string(firstname),
                "last_name": .string(lastname),
                "phone_number": .string(phone),
                "email": .string(email)
            ]
        )
        
        guard let session = response.session else {
            print("no session")
            throw NSError()
        }
        
        return AppUser(session: session)
    }


    @discardableResult
    func signInUser(email: String, password: String) async throws -> AppUser {
        let session = try await supabase.auth.signIn(email: email, password: password)
        print("Session: \(session)")
        return AppUser(session: session)
    }
    
    func logout() async throws {
        try await supabase.auth.signOut()
    }
}
