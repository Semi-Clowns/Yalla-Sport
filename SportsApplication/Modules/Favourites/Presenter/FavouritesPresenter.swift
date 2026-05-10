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
    
    init(view: FavouritesViewProtocol,coreDataManager: CoreDataManager = CoreDataManager.shared,networkMonitor: NetworkMonitor = NetworkMonitor.shared ) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.networkMonitor = networkMonitor
    }
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoading()
        coreDataManager.addToFavourites(league: League(
            id: 152,
            leagueName: "Premier League",
            leagueLogo: "https://apiv2.allsportsapi.com/logo/logo_leagues/152_premier-league.png",
            countryName: "England",
            countryLogo: "https://apiv2.allsportsapi.com/logo/logo_country/44_england.png",
            sportType: "Football"
        ))
        let favouritesDictnary = coreDataManager.getAllFavourites()
        
        let orderedFavourites = sportTypes.map { sport in
            favouritesDictnary[sport] ?? []
        }
        view?.hideLoading()
        let filteredLeagues = orderedFavourites.filter { !$0.isEmpty }
        let filteredSections = sportTypes.filter { sport in
            favouritesDictnary[sport] != nil && !(favouritesDictnary[sport]!.isEmpty)
        }
        if filteredLeagues.isEmpty {
            view?.showEmptyState()
        } else {
            view?.showFavourites(leagues: filteredLeagues, sections: filteredSections)
        }
        view?.hideLoading()
    }
        func deleteConfirmation(leagueId: Int) {
        view?.showDeleteAlert(leagueId: leagueId)
    }
    
    func removeFavourite(leagueId: Int) {
        coreDataManager.removeFromFavourites(leagueId: leagueId)
        viewDidLoad()
    }
    func  didSelectLeague(leagueId: Int,sportType:String) {
        if networkMonitor.isConnected {
                // Navigate to details
            print("there is internet")
            } else {
                view?.showNoInternet()
            }
        }
}
