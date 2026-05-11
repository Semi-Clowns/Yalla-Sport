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
    func filterData(searchText : String)
    func getSportType() -> String
}

class AllLeaguesPresenter : AllLeaguesPresenterProtocol{
    private var leagues = [League]()
    private var filteredLeagues = [League]()
    private let sportType : String
    var networkService: NetworkProtocol
    weak var view : AllLeaguesViewControllerProtocol?
    
    init(networkService: NetworkProtocol, displayLeaguesFor sportType: String) {
        self.networkService = networkService
        self.sportType = sportType
    }
    
    func attachView(withView view : AllLeaguesViewControllerProtocol) {
        self.view = view
    }
    
    func loadLeagues() {
        networkService.getAllLeagues(
            sport: sportType,
            responseType: LeagueResponse.self
        ) { [weak self] result in
            
            guard self != nil else {return}
            
            switch result {
                case .success(let response):
                    self?.leagues = response.result
                    self?.filteredLeagues = response.result
                    DispatchQueue.main.async {
                        self?.view?.showLeagues(leagues: self?.filteredLeagues ?? [])
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
//                        self?.view?.showError(message: error.localizedDescription)
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
        filteredLeagues[index].isFav.toggle()
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
    
    
}
