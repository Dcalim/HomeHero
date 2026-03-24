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
    
    @Dependency(\.configClient) var configClient
    
    @ObservableState
    struct State: Equatable {
        var data: ConfigResponse = ConfigResponse(
            profile: Profile(
                id: "",
                email: "",
                fullName: "",
                firstName: "",
                lastName: "",
                phoneNumber: "",
                homeCode: "",
                uiMode: EUiMode.light
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
                        let response = try await configClient.fetchConfig()
                        await send(.loadConfigResponse(.success(response)))
                    } catch {
                        await send(.loadConfigResponse(.failure(error)))
                    }
                }

            case .loadConfigResponse(.success(let response)):
                state.data = response
                state.isLoading = false
                print("\(state.data)")
                return .none

            case .loadConfigResponse(.failure(let error)):
                print("Config Error Occurred")
                print("\(error.localizedDescription)")
                state.error = error.localizedDescription
                state.isLoading = false
                return .none
            }
        }
    }
}
