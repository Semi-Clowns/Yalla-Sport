//
//  FavouritesPresenterProtocol.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 09/05/2026.
//
import Foundation
protocol FavouritesPresenterProtocol {
    func fetchFavourites()
    func removeFavourite(leagueId: Int)
    func deleteConfirmation(leagueId: Int)
    func didSelectLeague(indexPath:IndexPath)
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func getLeague(at indexPath: IndexPath) -> League
    func getSectionTitle(for section: Int) -> String 
}
