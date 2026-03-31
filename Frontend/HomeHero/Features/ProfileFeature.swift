//
//  ConfigFeature.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-14.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ProfileFeature {
    
    @Dependency(\.profileClient) var profileClient
    
    @ObservableState
    struct State: Equatable {
        var data: Profile = Profile(
                id: "",
                email: "",
                fullName: "",
                firstName: "",
                lastName: "",
                phoneNumber: "",
                homeCode: "",
                uiMode: EUiMode.dark
            )
        var isLoading = false
        var error: String?
    }
    
    enum Action {
        case loadProfile
        case loadProfileResponse(Result<Profile, Error>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {

            case .loadProfile:
                state.isLoading = true
                state.error = nil

                return .run { send in
                    do {
                        let response = try await profileClient.fetchProfile()
                        await send(.loadProfileResponse(.success(response)))
                    } catch {
                        await send(.loadProfileResponse(.failure(error)))
                    }
                }

            case .loadProfileResponse(.success(let response)):
                state.data = response
                state.isLoading = false
                print("Profile: \(state.data)")
                return .none

            case .loadProfileResponse(.failure(let error)):
                print("Config Error Occurred")
                print("\(error.localizedDescription)")
                state.error = error.localizedDescription
                state.isLoading = false
                return .none
            }
        }
    }
}
