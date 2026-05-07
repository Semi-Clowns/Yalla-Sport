//
//  LocalDataManager.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 06/05/2026.
//

import Foundation

protocol LocalDataManagerProtocol {
    func setHasSeenOnboarding(_ seen: Bool)
    func hasSeenOnboarding() -> Bool
}
class LocalDataManager: LocalDataManagerProtocol {
    
    static let shared = LocalDataManager()
    private let defaults = UserDefaults.standard
    private let onboardingKey = "hasSeenOnboarding"
    private init() {}

    func setHasSeenOnboarding(_ seen: Bool) {
        defaults.set(seen, forKey: onboardingKey)
    }

    func hasSeenOnboarding() -> Bool {
        return defaults.bool(forKey: onboardingKey)
    }
}
