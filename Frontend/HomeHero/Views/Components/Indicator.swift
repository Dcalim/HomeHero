//
//  Indicator.swift
//  HomeHero
//
//  Created by Antonio Conopio on 2025-12-02.
//

import SwiftUI

struct TabIndicator: View {
    let isActive: Bool
    let activeColor: Color
    let inactiveColor: Color
    let height: CGFloat
    
    init(
        isActive: Bool,
        activeColor: Color = .black,
        inactiveColor: Color = .clear,
        height: CGFloat = 4
    ) {
        self.isActive = isActive
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.height = height
    }
    
    var body: some View {
        Rectangle()
            .fill(isActive ? activeColor : inactiveColor)
            .frame(height: height)
            .cornerRadius(height / 2)
    }
}

#Preview {
    VStack(spacing: 8) {
        TabIndicator(isActive: true)
        TabIndicator(isActive: false)
    }
    .padding()
}
