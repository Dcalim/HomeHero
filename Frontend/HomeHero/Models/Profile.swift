//
//  Profile.swift
//  HomeHero
//
//  Created by Dion Calim on 2026-03-30.
//

enum EUiMode: String, Codable {
    case dark = "dark"
    case light = "light"
}

struct Profile: Codable, Equatable {
    let id: String
    let email: String
    let fullName: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let homeCode: String
    var uiMode: EUiMode

    init(
        id: String,
        email: String,
        fullName: String,
        firstName: String,
        lastName: String,
        phoneNumber: String,
        homeCode: String,
        uiMode: EUiMode = .dark
    ) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.homeCode = homeCode
        self.uiMode = uiMode
    }

    /// Custom decoder that gracefully handles null or missing fields from the API.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id          = try container.decode(String.self, forKey: .id)
        email       = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        fullName    = try container.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        firstName   = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        lastName    = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        homeCode    = try container.decodeIfPresent(String.self, forKey: .homeCode) ?? ""
        uiMode      = (try? container.decodeIfPresent(EUiMode.self, forKey: .uiMode)) ?? .dark
    }
}

extension Profile {
    static let mock = Profile(
            id: "1",
            email: "preview@test.com",
            fullName: "Preview User",
            firstName: "Preview",
            lastName: "User",
            phoneNumber: "1234567890",
            homeCode: "12345678",
            uiMode: .dark
        )
}
