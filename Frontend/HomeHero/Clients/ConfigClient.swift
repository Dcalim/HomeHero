//
//  ConfigClient.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-21.
//

import ComposableArchitecture
import Moya
import Foundation

struct ConfigClient {
    var fetchConfig: @Sendable () async throws -> ConfigResponse
}

extension ConfigClient: DependencyKey {
    static let liveValue = ConfigClient(
        fetchConfig: {
            try await fetchConfig()
        }
    )
    
    @MainActor
    private static func fetchConfig() async throws -> ConfigResponse {
        let provider = MoyaProvider<ConfigAPI>()
        let response = try await provider.asyncRequest(.fetchConfig)
        return try JSONDecoder().decode(ConfigResponse.self, from: response.data)
    }


    
    // FOR TESTING
    static let previewValue = ConfigClient(
        fetchConfig: {
            await ConfigResponse.mock
        }
    )

    static let testValue = ConfigClient(
        fetchConfig: {
            throw URLError(.notConnectedToInternet)
        }
    )
}

extension DependencyValues {
    var configClient: ConfigClient {
        get { self[ConfigClient.self] }
        set { self[ConfigClient.self] = newValue }
    }
}
