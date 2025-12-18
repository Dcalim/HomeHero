//
//  RootView.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-26.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    
    let store: StoreOf<AppFeature>
    @State private var showSignedInView: Bool = false
    
    var body: some View {
        ZStack{
            ContentView(store: store, showSignedInView: $showSignedInView)
        }
        .onAppear{
            Task{
                let authUser = try? await AuthenticationManager.shared.getAuthenticatedUser()
                self.showSignedInView = authUser == nil
            }
        }
        .fullScreenCover(isPresented: $showSignedInView){
            NavigationStack{
                AuthView(showSignedInView: $showSignedInView)
            }
        }
        
    }
}

#Preview {
    RootView(store: HomeHeroApp.store)
}
