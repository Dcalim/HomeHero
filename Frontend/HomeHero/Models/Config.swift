//
//  Config.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-10.
//

import Foundation

// MARK: - State

// MARK: - Actions
enum ConfigAction {
    case loadConfig
    case loadConfigSuccess(ConfigResponse)
    case loadConfigFailure(String)
}

// MARK: - Models (API response)
struct ConfigResponse: Codable {
    let profile: Profile
}

struct Profile: Codable {
    let id: String
    let email: String
    let fullName: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
}

extension ConfigResponse {
    static let mock = ConfigResponse(
        profile: Profile(
            id: "1",
            email: "preview@test.com",
            fullName: "Preview User",
            firstName: "Preview",
            lastName: "User",
            phoneNumber: "1234567890"
        )
    )
}
