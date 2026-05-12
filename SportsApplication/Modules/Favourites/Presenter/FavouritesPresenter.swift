//
//  FavouritesPresenter.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 09/05/2026.
//
import Foundation
final class FavouritesPresenter {
    
    private weak var view: FavouritesViewProtocol?
    private let coreDataManager: CoreDataManager
    private let networkMonitor: NetworkMonitor
    private var favourites: [[League]] = []
    private var sectionTitles: [String] = []
    private let sportTypes = ["football", "basketball", "tennis", "cricket"]
    
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
           

            self.favourites = orderedFavourites.filter { !$0.isEmpty }
            self.sectionTitles = sportTypes.filter { !(favouritesDictionary[$0]?.isEmpty ?? true) }
            

            view?.hideLoading()
            
            if self.favourites.isEmpty {
                view?.showEmptyState()
            } else {
                view?.showFavourites()
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
    
    func didSelectLeague(indexPath:IndexPath) {
        if networkMonitor.isConnected {
            let league = getLeague(at: indexPath)
            self.view?.navigateToLeagueDetails(with: league, sport : league.sportType ?? "other" )
        } else {
            view?.showNoInternet()
        }
    }
    
    
    func numberOfSections() -> Int{
        return sectionTitles.count
    }
    func numberOfItems(in section: Int) -> Int {
            return favourites[section].count
        }
        
        func getLeague(at indexPath: IndexPath) -> League {
            return favourites[indexPath.section][indexPath.row]
        }
        
        func getSectionTitle(for section: Int) -> String {
            return sectionTitles[section]
        }
}
