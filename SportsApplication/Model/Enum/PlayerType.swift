//
//  PlayerType.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import UIKit

enum PlayerType: String, Codable {
    case goalkeepers = "Goalkeepers"
    case defenders   = "Defenders"
    case midfielders = "Midfielders"
    case forwards    = "Forwards"
    case coach     = "Coach"

    var badgeColor: UIColor {
        switch self {
        case .goalkeepers: return UIColor(hex: "#F5A623")
        case .defenders:   return UIColor(hex: "#4A90D9")
        case .midfielders: return UIColor(hex: "#27AE60")
        case .forwards:    return UIColor(hex: "#E74C3C")
        case .coach:     return UIColor.systemGray
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self = PlayerType(rawValue: value) ?? .coach
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hex = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        self.init(
            red:   CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8)  & 0xFF) / 255,
            blue:  CGFloat( rgb        & 0xFF) / 255,
            alpha: 1
        )
    }
}
