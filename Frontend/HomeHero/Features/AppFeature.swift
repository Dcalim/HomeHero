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
    }
    
    enum Action {
        case config(ConfigFeature.Action)
        case ui(UIFeature.Action)
    }
    
    var body: some Reducer<State, Action>{
        // Allows us to use the reducer functions in the Config Feature (Child)
        Scope(state: \.config, action: \.config) {
            ConfigFeature()
        }
        
        Scope(state: \.ui, action: \.ui) {
            UIFeature()
        }
        
        Reduce { state, action in
          // Core logic of the app feature
          return .none
        }
    }
}
