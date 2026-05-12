//
//  FavouritesViewProtocol.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 09/05/2026.
//
protocol FavouritesViewProtocol: AnyObject {
    func showFavourites()
    func showEmptyState()
    func showError(message: String)
    func showLoading()
    func hideLoading()
    func showDeleteAlert(leagueId: Int)
    func showNoInternet()
    func navigateToLeagueDetails(with league: League )
}
