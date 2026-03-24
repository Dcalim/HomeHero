//
//  Theme.swift
//  HomeHero
//

import SwiftUI

// MARK: - Hex Color Support

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Adaptive Color Support

extension Color {
    /// Creates a Color that dynamically resolves based on the current interface style.
    init(light: Color, dark: Color) {
        self.init(uiColor: UIColor { traits in
            traits.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}

// MARK: - Theme

struct Theme {

    // MARK: Raw Palette

    static let deepNavy   = Color(hex: "2F6690")
    static let mediumBlue = Color(hex: "3A7CA5")
    static let warmGray   = Color(hex: "D9DCD6")
    static let darkNavy   = Color(hex: "16425B")
    static let skyBlue    = Color(hex: "81C3D7")

    // MARK: Semantic Colors (adaptive light / dark)

    static let primary         = Color(light: deepNavy,            dark: mediumBlue)
    static let secondary       = Color(light: mediumBlue,          dark: deepNavy)
    static let background      = Color(light: Color(hex: "F4F5F2"), dark: Color(hex: "0D1B2A"))
    static let cardBackground  = Color(light: .white,              dark: Color(hex: "152535"))
    static let textPrimary     = Color(light: darkNavy,            dark: Color(hex: "F0F2F5"))
    static let textSecondary   = Color(light: mediumBlue,          dark: skyBlue)
    static let textTertiary    = Color(light: Color(hex: "8E8E93"), dark: Color(hex: "7A8D9C"))
    static let accent          = skyBlue
    static let error           = Color(light: Color(hex: "D9534F"), dark: Color(hex: "FF6B6B"))
    static let success         = Color(light: Color(hex: "27AE60"), dark: Color(hex: "4ADE80"))
    static let inputBackground = Color(light: .white,              dark: Color(hex: "152535"))
    static let inputBorder     = Color(light: warmGray,            dark: Color(hex: "1E3D54"))
    static let dividerColor    = Color(light: warmGray,            dark: Color(hex: "1E3D54"))

    // MARK: Gradients

    static let primaryGradient = LinearGradient(
        colors: [Color(light: deepNavy, dark: mediumBlue), skyBlue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: Typography

    struct Fonts {
        static let largeTitle = Font.system(size: 32, weight: .bold, design: .rounded)
        static let title      = Font.system(size: 24, weight: .bold, design: .rounded)
        static let title3     = Font.system(size: 20, weight: .semibold, design: .rounded)
        static let headline   = Font.system(size: 17, weight: .semibold, design: .rounded)
        static let body       = Font.system(size: 16, weight: .regular, design: .rounded)
        static let callout    = Font.system(size: 15, weight: .medium, design: .rounded)
        static let caption    = Font.system(size: 13, weight: .regular, design: .rounded)
        static let small      = Font.system(size: 11, weight: .regular, design: .rounded)
    }

    // MARK: Layout Constants

    struct Layout {
        static let cornerRadius: CGFloat    = 14
        static let buttonHeight: CGFloat    = 54
        static let inputHeight: CGFloat     = 54
        static let horizontalPadding: CGFloat = 24
        static let verticalSpacing: CGFloat = 16
        static let shadowRadius: CGFloat    = 10
        static let shadowY: CGFloat         = 4
    }
}
