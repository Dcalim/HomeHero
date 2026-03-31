//
//  AppFeature.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-14.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    
    @ObservableState
    struct State: Equatable {
        var profileFeature = ProfileFeature.State()
        var homesFeature = HomesFeature.State()
        var ui = UIFeature.State()
        var auth = AuthFeature.State()
    }
    
    enum Action {
        case profileFeature(ProfileFeature.Action)
        case homesFeature(HomesFeature.Action)
        case ui(UIFeature.Action)
        case auth(AuthFeature.Action)
    }
    
    var body: some Reducer<State, Action>{
        // Allows us to use the reducer functions in the Config Feature (Child)
        Scope(state: \.profileFeature, action: \.profileFeature) {
            ProfileFeature()
        }
        
        Scope(state: \.homesFeature, action: \.homesFeature) {
            HomesFeature()
        }
        
        Scope(state: \.ui, action: \.ui) {
            UIFeature()
        }
        
        Scope(state: \.auth, action: \.auth) {
            AuthFeature()
        }
        
        Reduce { state, action in
            switch action {

            case .auth(.signInResponse(.success)):
                print("Login Successful")
                // Auth just succeeded → load config
                return .send(.profileFeature(.loadProfile))

            case .auth(.signOut):
                // Optional: reset config on logout
                state.profileFeature = ProfileFeature.State()
                return .none
                
            case .profileFeature(.loadProfileResponse(.success)):
                print("Fetch Profiles Successful")
                return .send(.homesFeature(.loadHomes))

            default:
                return .none
            }
        }
    }
}
