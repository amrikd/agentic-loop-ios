import SwiftUI

// MARK: - Color hex initializer
extension Color {
    /// Initialize a `Color` from a 6-digit hex string (e.g. `"#1A1A2E"` or `"1A1A2E"`).
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .init(charactersIn: "#"))
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8)  & 0xFF) / 255
        let b = Double(rgb         & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Design Tokens
enum DesignTokens {

    // MARK: Colors
    enum Colors {
        // Backgrounds
        static let background      = Color(hex: "0D0D0D")
        static let surface         = Color(hex: "1A1A2E")
        static let surfaceElevated = Color(hex: "252545")

        // Text
        static let textPrimary     = Color(hex: "F0F0F0")
        static let textSecondary   = Color(hex: "9090A0")
        static let textMuted       = Color(hex: "505060")

        // Brand
        static let accent          = Color(hex: "7C5CBF")
        static let accentLight     = Color(hex: "A07EE0")

        // Status
        static let success         = Color(hex: "4CAF50")
        static let warning         = Color(hex: "FF9800")
        static let error           = Color(hex: "F44336")

        // Mood scale: 1 (red) → 5 (indigo)
        static let mood1           = Color(hex: "F44336") // red
        static let mood2           = Color(hex: "FF9800") // orange
        static let mood3           = Color(hex: "FFEB3B") // yellow
        static let mood4           = Color(hex: "4CAF50") // green
        static let mood5           = Color(hex: "3F51B5") // indigo

        static func moodColor(for score: Int) -> Color {
            switch score {
            case 1:  return mood1
            case 2:  return mood2
            case 3:  return mood3
            case 4:  return mood4
            case 5:  return mood5
            default: return textMuted
            }
        }
    }

    // MARK: Typography
    enum Typography {
        static let largeTitle  = Font.largeTitle.weight(.bold)
        static let title       = Font.title2.weight(.semibold)
        static let headline    = Font.headline.weight(.semibold)
        static let body        = Font.body
        static let caption     = Font.caption
        static let footnote    = Font.footnote
    }

    // MARK: Spacing
    enum Spacing {
        static let xxs: CGFloat = 4
        static let xs:  CGFloat = 8
        static let sm:  CGFloat = 12
        static let md:  CGFloat = 16
        static let lg:  CGFloat = 24
        static let xl:  CGFloat = 32
        static let xxl: CGFloat = 48
    }

    // MARK: Corner Radius
    enum Radius {
        static let sm:  CGFloat = 8
        static let md:  CGFloat = 12
        static let lg:  CGFloat = 16
        static let xl:  CGFloat = 24
        static let full: CGFloat = 999
    }
}
