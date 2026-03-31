//
//  HomesFeature.swift
//  HomeHero
//
//  Created by Dion Calim on 2026-03-30.
//

import ComposableArchitecture
import Foundation

@Reducer
struct HomesFeature {
    
    @Dependency(\.homeClient) var homeClient
    
    @ObservableState
    struct State: Equatable {
        var data: [Home] = []
        var selectedHome: Home? = nil
        var isLoading = false
        var error: String?
    }
    
    enum Action {
        case loadHomes
        case loadHomesResponse(Result<[Home], Error>)
        case selectHome(Home)
        case leaveHome
        case addHome
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {

            case .loadHomes:
                state.isLoading = true
                state.error = nil

                return .run { send in
                    do {
                        let response = try await homeClient.fetchHomes()
                        await send(.loadHomesResponse(.success(response)))
                    } catch {
                        await send(.loadHomesResponse(.failure(error)))
                    }
                }

            case .loadHomesResponse(.success(let response)):
                state.data = response
                state.isLoading = false
                if state.selectedHome == nil, let first = response.first {
                    state.selectedHome = first
                }
                print("Home: \(state.data)")
                return .none

            case .loadHomesResponse(.failure(let error)):
                print("Home Fetch Error Occurred")
                print("\(error.localizedDescription)")
                state.error = error.localizedDescription
                state.isLoading = false
                return .none

            case .selectHome(let home):
                state.selectedHome = home
                return .none

            case .leaveHome:
                // TODO: Implement leave household
                return .none

            case .addHome:
                // TODO: Implement add household
                return .none
            }
        }
    }
}
