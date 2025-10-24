//
//  Item.swift
//  HomeHero
//
//  Created by Antonio conopio on 2025-10-24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
