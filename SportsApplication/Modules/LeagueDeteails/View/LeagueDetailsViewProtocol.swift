//
//  LeagueDetailsViewProtocol.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 11/05/2026.
//

import Foundation
protocol LeagueDetailsViewProtocol :AnyObject {
    func showLoading()
        func hideLoading()
        func reloadCollectionView()
        func showError(message: String)
        func setLeagueTitle(title: String)   
        func updateFavoriteButtonState(isFavorite: Bool)
        func showDeleteAlert(leagueId: Int)

    
}
