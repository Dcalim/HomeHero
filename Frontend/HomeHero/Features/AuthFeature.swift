//
//  AuthFeature.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-23.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AuthFeature {
    
    private var authManager = AuthenticationManager.shared

    @ObservableState
    struct State: Equatable {
        var isSignedIn: Bool = false
        var authToken: String = ""
        var errorMessage: String?
    }

    enum Action {
        case checkAuthentication
        case signInButtonTapped(email: String, password: String)
        case signUpButtonTapped(
                email: String,
                password: String,
                firstName: String,
                lastName: String,
                phone: String
            )
        case signInResponse(Result<Void, Error>)
        case signOut
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .signInButtonTapped(let email, let password):
                state.errorMessage = nil
                return .run { send in
                    do {
                        try await authManager.signInUser(
                            email: email,
                            password: password
                        )
                        await send(.signInResponse(.success(())))
                    } catch {
                        await send(.signInResponse(.failure(error)))
                    }
                }
                
            case let .signUpButtonTapped(email, password, firstName, lastName, phone):
                state.errorMessage = nil
                return .run { send in
                    do {
                        try await authManager.createUser(
                            email: email,
                            password: password,
                            firstname: firstName,
                            lastname: lastName,
                            phone: phone
                        )
                        await send(.signInResponse(.success(())))
                    } catch {
                        await send(.signInResponse(.failure(error)))
                    }
                }
                
            case .signInResponse(.success()):
                state.isSignedIn = true
                state.authToken = authManager.authToken
                state.errorMessage = nil
                return .none

            case .signInResponse(.failure(let error)):
                state.isSignedIn = false
                state.errorMessage = error.localizedDescription
                return .none

            case .signOut:
                state.isSignedIn = false
                state.authToken = ""
                return .run { _ in
                    try await authManager.logout()
                }
            case .checkAuthentication:
                return .run { send in
                    do {
                        _ = try await authManager.getAuthenticatedUser()
                        await send(.signInResponse(.success(())))
                    } catch {
                        await send(.signInResponse(.failure(error)))
                    }
                }
            }
        }
    }
}

