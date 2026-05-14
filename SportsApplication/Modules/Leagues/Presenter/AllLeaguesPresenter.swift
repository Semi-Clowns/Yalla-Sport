//
//  AllLeaguesPresenter.swift
//  SportsApplication
//
//  Created by Moaz on 09/05/2026.
//

import Foundation


protocol AllLeaguesPresenterProtocol {
    func loadLeagues()
    func attachView(withView view : AllLeaguesViewControllerProtocol)
    func getLeaguesCount() -> Int
    func getLeagueAtIndex(at index : Int) -> League
    func toggleFavorite(at index: Int)
    func confirmRemoveFavorite(at index: Int)
    func filterData(searchText : String)
    func getSportType() -> String
    func navigateToLeagueDetails(index: Int)
    func refreshFavoriteStates()

}

class AllLeaguesPresenter : AllLeaguesPresenterProtocol{
    private var leagues = [League]()
    private var filteredLeagues = [League]()
    private let sportType : String
    var networkService: NetworkProtocol
    var coreDataManager: CoreDataManager
    private let networkMonitor: NetworkMonitor


    weak var view : AllLeaguesViewControllerProtocol?
    
    init(networkService: NetworkProtocol, displayLeaguesFor sportType: String,coreDataManager : CoreDataManager = CoreDataManager.shared,networkMonitor : NetworkMonitor = NetworkMonitor.shared) {
        self.networkService = networkService
        self.sportType = sportType
        self.coreDataManager = coreDataManager
        self.networkMonitor = networkMonitor
    }
    
    func attachView(withView view : AllLeaguesViewControllerProtocol) {
        self.view = view
    }
    
    func loadLeagues() {
        view?.showLoading()
        networkService.getAllLeagues(
            sport: sportType,
            responseType: LeagueResponse.self
        ) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(let response):
                let updatedLeagues = response.result.map { league -> League in
                                        var mutableLeague = league
                    mutableLeague.isFav = self.isFavouratie(leagueid: mutableLeague.id)
                                        return mutableLeague
                                    }
                    self.leagues = updatedLeagues
                    self.filteredLeagues = updatedLeagues
              
                            DispatchQueue.main.async {
                        self.view?.showLeagues(leagues: self.filteredLeagues )
                                self.view?.hideLoading()
                    }
            case .failure(_):
                    DispatchQueue.main.async {
                        self.view?.hideLoading()

                        self.view?.showError(message: "Could not laod data due to server error")
                    }
            }
        }
    }
    
    func getLeaguesCount() -> Int {
        filteredLeagues.count
    }
    
    func getLeagueAtIndex(at index : Int) -> League {
        var league = filteredLeagues[index]
        league.sportType = getSportType()
        return league
    }
    
    func toggleFavorite(at index: Int) {
        var league = filteredLeagues[index]
        
        if league.isFav {
            view?.showDeleteConfirmation(for: index, leagueName: league.leagueName ?? "this league")
        } else {
            do {
                league.sportType = getSportType()
                try coreDataManager.addToFavourites(league: league)
                updateFavoriteStatusLocally(at: index, isFav: true)
                view?.reloadRow(at: index)
            } catch {
                view?.showError(message: "Could not save to favorites")
            }
        }
    }
    
    func confirmRemoveFavorite(at index: Int) {
        let league = filteredLeagues[index]
        do {
            try coreDataManager.removeFromFavourites(leagueId: league.id)
            updateFavoriteStatusLocally(at: index, isFav: false)
            view?.reloadRow(at: index)
        } catch {
            view?.showError(message: "Could not remove from favorites")
        }
    }
    
    private func updateFavoriteStatusLocally(at index: Int, isFav: Bool) {
        filteredLeagues[index].isFav = isFav
        
        let leagueId = filteredLeagues[index].id
        if let mainIndex = leagues.firstIndex(where: { $0.id == leagueId }) {
            leagues[mainIndex].isFav = isFav
        }
    }
    
    func filterData(searchText : String) {
        if searchText.isEmpty {
            filteredLeagues = leagues
        } else {
            filteredLeagues = leagues.filter { league in
                guard let name = league.leagueName else {return false}
                
                return name.lowercased().starts(with: searchText.lowercased())
            }
        }
    }
    
    func getSportType() -> String{
        self.sportType
    }
    
   private func isFavouratie(leagueid :Int) -> Bool {
       return coreDataManager.isFavourite(leagueId: leagueid)
    }
    func navigateToLeagueDetails(index: Int) {
        if networkMonitor.isConnected{
            let league = getLeagueAtIndex(at: index)
            self.view?.navigateToLeagueDetails(with :league,sport: sportType)
        }
        else{
            self.view?.showNoInternet()
            
        }
}
    func refreshFavoriteStates() {
        guard !leagues.isEmpty else { return }  
           
           leagues = leagues.map { league in
               var updated = league
               updated.isFav = isFavouratie(leagueid: league.id)
               return updated
           }
           filteredLeagues = filteredLeagues.map { league in
               var updated = league
               updated.isFav = isFavouratie(leagueid: league.id)
               return updated
           }
           DispatchQueue.main.async {
               self.view?.showLeagues(leagues: self.filteredLeagues)
           }
}
}
