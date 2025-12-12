//
//  ConfigManager.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-10.
//

import Foundation

class ConfigManager {
    static let shared = ConfigManager()
    private init() {}

    func loadConfig() async throws -> ConfigResponse {
        try await ApiService.Config.fetchConfig()
    }
}
