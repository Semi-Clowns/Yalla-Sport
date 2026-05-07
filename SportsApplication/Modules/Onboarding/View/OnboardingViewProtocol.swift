//
//  OnboardingViewProtocol.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 07/05/2026.
//
import Foundation
protocol OnboardingViewProtocol: AnyObject {
    func updateUI(index: Int, isLastPage: Bool)
    func navigateToMainApp()
}
