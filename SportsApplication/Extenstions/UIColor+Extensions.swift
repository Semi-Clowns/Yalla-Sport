//
//  Colors.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 06/05/2026.
//

import UIKit
extension UIColor {
    static let primaryText = UIColor(named: "PrimaryTextColor")
    static let primaryColor = UIColor(named: "PrimaryColor")
    static let BackgroundColor = UIColor(named: "BackgroundColor")
    static let secondaryText = UIColor(named: "secondaryextColor")
    
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

