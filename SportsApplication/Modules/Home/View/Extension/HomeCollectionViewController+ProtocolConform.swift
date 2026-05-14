//
//  HomeCollectionViewController+ProtocolConform.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 14/05/2026.
//

import UIKit

extension HomeCollectionViewController :HomeViewControllerProtocol {
   
    func showNoInternet() {
        AppAlerts.showNoInternet(on: self)
        }
    func navigateToDisplayLeague(sport: Sport) {
        performSegue(withIdentifier: "goToAllLeagues", sender: sport  )
    }
}
