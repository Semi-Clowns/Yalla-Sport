//
//  AllLeaguesPresenterProtocol.swift
//  SportsApplication
//
//  Created by Moaz on 14/05/2026.
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
}
