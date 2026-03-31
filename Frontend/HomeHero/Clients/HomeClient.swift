//
//  HomeClient.swift
//  HomeHero
//
//  Created by Dion Calim on 2026-03-30.
//

import ComposableArchitecture
import Moya
import Foundation

struct HomeClient {
    var fetchHomes: @Sendable () async throws -> [Home]
}

extension HomeClient: DependencyKey {
    static let liveValue = HomeClient(
        fetchHomes: {
            try await fetchHomes()
        }
    )
    
    @MainActor
    private static func fetchHomes() async throws -> [Home] {
        let provider = MoyaProvider<HomeApi>()
        let response = try await provider.asyncRequest(.fetchHomes)
        return try JSONDecoder().decode([Home].self, from: response.data)
    }


    
    // FOR TESTING
    static let previewValue = HomeClient(
        fetchHomes: {
            await [Home.mock]
        }
    )

    static let testValue = HomeClient(
        fetchHomes: {
            throw URLError(.notConnectedToInternet)
        }
    )
}

extension DependencyValues {
    var homeClient: HomeClient {
        get { self[HomeClient.self] }
        set { self[HomeClient.self] = newValue }
    }
}
