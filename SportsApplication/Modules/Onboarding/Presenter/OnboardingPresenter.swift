//
//  OnboardingPresenter.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 06/05/2026.
//

import Foundation


class OnboardingPresenter: OnboardingPresenterProtocol {

    weak var view: OnboardingViewProtocol?
    private let pageIdentifiers: [String] = ["page1", "page2"]
    private let localDataManager: LocalDataManagerProtocol
    var pageCount: Int {
        pageIdentifiers.count
    }

    init(view: OnboardingViewProtocol,localDataManager: LocalDataManagerProtocol = LocalDataManager.shared) {
        self.view = view
        self.localDataManager = localDataManager
    }

    func getPages() -> [String] {
        return pageIdentifiers
    }

    func viewDidLoad() {
        view?.updateUI(index: 0, isLastPage: pageCount == 1)
    }

    func nextTapped(currentIndex: Int) {
        guard currentIndex < pageCount else { return }
        let nextIndex = currentIndex + 1
        if nextIndex < pageCount {
            view?.updateUI(index: nextIndex, isLastPage: nextIndex == pageCount - 1)
        } else {
            localDataManager.setHasSeenOnboarding(true)
            view?.navigateToMainApp()
        }
    }

    func didSwipeToPage(index: Int) {
        guard index >= 0, index < pageCount else { return }
        view?.updateUI(index: index, isLastPage: index == pageCount - 1)
    }

    func skipTapped() {
        localDataManager.setHasSeenOnboarding(true)
        view?.navigateToMainApp()
    }
}
