//
//  LocalDataManager.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 06/05/2026.
//

import Foundation

class LocalDataManager: LocalDataManagerProtocol {
    
    static let shared = LocalDataManager()
    private let defaults = UserDefaults.standard
    private let onboardingKey = "hasSeenOnboarding"
    private let isDarkModeKey = "isDarkMode"
    private init() {}

    func setHasSeenOnboarding(_ seen: Bool) {
        defaults.set(seen, forKey: onboardingKey)
    }

    func hasSeenOnboarding() -> Bool {
        return defaults.bool(forKey: onboardingKey)
    }
    
    func isDarkMode() -> Bool {
        return defaults.bool(forKey: isDarkModeKey)
    }
    
    func setDarkMode(isDark: Bool) {
        defaults.set(isDark, forKey: isDarkModeKey)
    }
}
