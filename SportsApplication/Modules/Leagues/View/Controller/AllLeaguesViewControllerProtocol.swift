//
//  AllLeaguesViewControllerProtocol.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import Foundation

protocol AllLeaguesViewControllerProtocol : AnyObject {
    func showLeagues(leagues: [League])
    func reloadRow(at index: Int)
    func showDeleteConfirmation(for index: Int, leagueName: String)
    func showError(message: String)
    func showLoading()
    func hideLoading()
    func showNoInternet()
    func navigateToLeagueDetails(with league: League,sport:String)
}
