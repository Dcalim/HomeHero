//
//  ConfigFeature.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-14.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ConfigFeature {
    @ObservableState
    struct State {
        var data: ConfigResponse = ConfigResponse(
            profile: Profile(
                id: "",
                email: "",
                fullName: "",
                firstName: "",
                lastName: "",
                phoneNumber: ""
            )
        )
        var isLoading = false
        var error: String?
    }
    
    enum Action {
        case loadConfig
        case loadConfigResponse(Result<ConfigResponse, Error>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {

            case .loadConfig:
                state.isLoading = true
                state.error = nil

                return .run { send in
                    do {
                        let response = try await ApiService.Config.fetchConfig()
                        await send(.loadConfigResponse(.success(response)))
                    } catch {
                        await send(.loadConfigResponse(.failure(error)))
                    }
                }

            case .loadConfigResponse(.success(let response)):
                state.isLoading = false
                state.data = response

                return .none

            case .loadConfigResponse(.failure(let error)):
                state.isLoading = false
                state.error = error.localizedDescription
                return .none
            }
        }
    }
}
