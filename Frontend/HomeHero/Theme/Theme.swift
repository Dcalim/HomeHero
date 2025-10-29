//
//  Theme.swift
//  fishon
//
//  Created by Antonio conopio on 2025-09-28.
//

import SwiftUI

struct Theme {
    // Colors (defined in Assets.xcassets)
    static let background = Color("AppBackground")
    static let accent = Color("AppAccent")
    static let textPrimary = Color("TextPrimary")
    
    // Fonts
    struct Font {
        static let title = SwiftUI.Font.system(.title, design: .rounded).weight(.bold)
        static let body = SwiftUI.Font.system(.body, design: .rounded)
    }
}
