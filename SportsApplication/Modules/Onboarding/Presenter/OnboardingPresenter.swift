//
//  OnboardingPresenter.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 06/05/2026.
//

import Foundation

class OnboardingPresenter: OnboardingPresenterProtocol {
 

    weak var view: OnboardingViewProtocol?
    private let pageIdentifiers: [String] 
    private let localDataManager: LocalDataManagerProtocol
    

    init(view: OnboardingViewProtocol,localDataManager: LocalDataManagerProtocol = LocalDataManager.shared,pageIdentifiers: [String] = ["page1", "page2"] ) {
        self.view = view
        self.localDataManager = localDataManager
        self.pageIdentifiers = pageIdentifiers
    }

    func getPages() -> [String] {
        return pageIdentifiers
    }
    func getPageCount() -> Int {
        pageIdentifiers.count
    }
    func viewDidLoad() {
        view?.updateUI(index: 0, isLastPage: getPageCount() == 1)
    }

    func nextTapped(currentIndex: Int) {
        guard currentIndex < getPageCount() else { return }
        let nextIndex = currentIndex + 1
        if nextIndex < getPageCount() {
            view?.updateUI(index: nextIndex, isLastPage: nextIndex == getPageCount() - 1)
        } else {
            localDataManager.setHasSeenOnboarding(true)
            view?.navigateToMainApp()
        }
    }

    func didSwipeToPage(index: Int) {
        guard index >= 0, index < getPageCount() else { return }
        view?.updateUI(index: index, isLastPage: index == getPageCount() - 1)
    }

    func skipTapped() {
        localDataManager.setHasSeenOnboarding(true)
        view?.navigateToMainApp()
    }
}
