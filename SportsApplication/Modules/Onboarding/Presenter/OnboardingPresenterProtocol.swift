//
//  OnboardingPresenterProtocol.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 07/05/2026.
//
import Foundation

protocol OnboardingPresenterProtocol {
    var pageCount: Int { get }
    func viewDidLoad()
    func nextTapped(currentIndex: Int)
    func didSwipeToPage(index: Int)
    func skipTapped()
    func getPages() -> [String]
}
