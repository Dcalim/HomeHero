//
//  RootView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-26.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignedInView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                ContentView(showSignInView: $showSignedInView)
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignedInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignedInView){
            NavigationStack{
                AuthView()
            }
        }
        
    }
}

#Preview {
    RootView()
}
