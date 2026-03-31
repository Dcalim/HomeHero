//
//  Home.swift
//  HomeHero
//
//  Created by Dion Calim on 2026-03-30.
//

struct Home: Codable, Equatable {
    let id: Int
    let name: String
    let homeCode: String
}

extension Home {
    static let mock = Home(
            id: 1,
            name: "Simpson",
            homeCode: "12345678"
        )
}
