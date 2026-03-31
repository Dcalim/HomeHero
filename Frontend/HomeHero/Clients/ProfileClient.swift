//
//  ConfigClient.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-21.
//

import ComposableArchitecture
import Moya
import Foundation

struct ProfileClient {
    var fetchProfile: @Sendable () async throws -> Profile
}

extension ProfileClient: DependencyKey {
    static let liveValue = ProfileClient(
        fetchProfile: {
            try await fetchProfile()
        }
    )
    
    @MainActor
    private static func fetchProfile() async throws -> Profile {
        let provider = MoyaProvider<ProfileApi>()
        let response = try await provider.asyncRequest(.fetchProfile)
        return try JSONDecoder().decode(Profile.self, from: response.data)
    }


    
    // FOR TESTING
    static let previewValue = ProfileClient(
        fetchProfile: {
            await Profile.mock
        }
    )

    static let testValue = ProfileClient(
        fetchProfile: {
            throw URLError(.notConnectedToInternet)
        }
    )
}

extension DependencyValues {
    var profileClient: ProfileClient {
        get { self[ProfileClient.self] }
        set { self[ProfileClient.self] = newValue }
    }
}
