//
//  FavouritesPresenterProtocol.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 09/05/2026.
//

protocol FavouritesPresenterProtocol {
    func fetchFavourites()
    func removeFavourite(leagueId: Int)
    func deleteConfirmation(leagueId: Int)
    func didSelectLeague(leagueId: Int,sportType:String)
}
