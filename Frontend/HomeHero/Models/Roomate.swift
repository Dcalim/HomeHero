//
//  Roomate.swift
//  HomeHero
//
//  Created by Antonio Conopio on 2025-12-02.
//

import Foundation

struct Roomate: Identifiable, Codable {
    let id: UUID
    let name: String
    let imageURL: String
    let status: Status
    let location: Location
    let leader: Leader
    
    enum Status: String, Codable, CaseIterable {
        case online = "Online"
        case offline = "Offline"
    }
    
    enum Location: String, Codable, CaseIterable {
        case home = "Home"
        case away = "Away"
    }
    
    enum Leader: Int, Codable, CaseIterable {
        case leader = 1
        case member = 0
    }
    
    init(
        id: UUID = UUID(),
        name: String,
        imageURL: String,
        status: Status,
        location: Location,
        leader: Leader
    ) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.status = status
        self.location = location
        self.leader = leader
    }
}
