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
        var config = ConfigFeature.State()
        var ui = UIFeature.State()
        var auth = AuthFeature.State()
    }
    
    enum Action {
        case config(ConfigFeature.Action)
        case ui(UIFeature.Action)
        case auth(AuthFeature.Action)
    }
    
    var body: some Reducer<State, Action>{
        // Allows us to use the reducer functions in the Config Feature (Child)
        Scope(state: \.config, action: \.config) {
            ConfigFeature()
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
                // Auth just succeeded → load config
                return .send(.config(.loadConfig))

            case .auth(.signOut):
                // Optional: reset config on logout
                state.config = ConfigFeature.State()
                return .none

            default:
                return .none
            }
        }
    }
}
