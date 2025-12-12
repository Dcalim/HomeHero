//
//  ConfigReducer.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-10.
//

import Foundation

struct ConfigReducer {
    func reduce(_ state: inout ConfigState, _ action: ConfigAction) {
        switch action {
        case .loadConfig:
            state.isLoading = true
            state.error = nil

        case .loadConfigSuccess(let response):
            state.isLoading = false
            state.data = response

        case .loadConfigFailure(let message):
            state.isLoading = false
            state.error = message
        }
    }
}
