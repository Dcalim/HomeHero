//
//  ConfigSelector.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-10.
//

extension Store {
    func selectProfile() -> Profile {
        appState.config.data.profile
    }

    func selectIsConfigLoading() -> Bool {
        appState.config.isLoading
    }

    func selectConfigError() -> String? {
        appState.config.error
    }
}
