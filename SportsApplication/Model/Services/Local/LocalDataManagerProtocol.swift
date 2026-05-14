//
//  LocalDataManagerProtocol.swift
//  SportsApplication
//
//  Created by Moaz on 14/05/2026.
//

import Foundation

protocol LocalDataManagerProtocol {
    func setHasSeenOnboarding(_ seen: Bool)
    func hasSeenOnboarding() -> Bool
    func isDarkMode() -> Bool
    func setDarkMode(isDark: Bool)
}
