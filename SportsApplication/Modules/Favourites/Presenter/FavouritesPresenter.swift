//
//  FavouritesPresenter.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 09/05/2026.
//

final class FavouritesPresenter {
    
    private weak var view: FavouritesViewProtocol?
    private let coreDataManager: CoreDataManager
    private let networkMonitor: NetworkMonitor
    
    private let sportTypes = ["Football", "Basketball", "Tennis", "Cricket"]
    
    init(view: FavouritesViewProtocol,
         coreDataManager: CoreDataManager = CoreDataManager.shared,
         networkMonitor: NetworkMonitor = NetworkMonitor.shared) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.networkMonitor = networkMonitor
    }
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    
    func fetchFavourites() {
        view?.showLoading()
        
        do {
            let favouritesDictionary = try coreDataManager.getAllFavourites()
            
            let orderedFavourites = sportTypes.map { sport in
                favouritesDictionary[sport] ?? []
            }
            
            let filteredLeagues = orderedFavourites.filter { !$0.isEmpty }
            let filteredSections = sportTypes.filter { sport in
                !(favouritesDictionary[sport]?.isEmpty ?? true)
            }
            
            view?.hideLoading()
            
            if filteredLeagues.isEmpty {
                view?.showEmptyState()
            } else {
                view?.showFavourites(leagues: filteredLeagues, sections: filteredSections)
            }
        } catch {
            view?.hideLoading()
            view?.showError(message: "Failed to load favourites")
        }
    }
    

    
    func deleteConfirmation(leagueId: Int) {
        view?.showDeleteAlert(leagueId: leagueId)
    }
    
    func removeFavourite(leagueId: Int) {
        do {
            try coreDataManager.removeFromFavourites(leagueId: leagueId)
            fetchFavourites()
        } catch {
            view?.showError(message: "Could not remove league. Please try again.")
        }
    }
    
    func didSelectLeague(leagueId: Int, sportType: String) {
        if networkMonitor.isConnected {
            // naviage to details
            print("Navigating to \(leagueId)")
        } else {
            view?.showNoInternet()
        }
    }
}
