//
//  AllLeaguesViewController+AllLeaguesViewControllerProtocol.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import UIKit
import SkeletonView

extension AllLeaguesViewController : AllLeaguesViewControllerProtocol{
    func showLeagues(leagues: [League]) {
        leaguesTableView.reloadData()
    }
    func reloadRow(at index: Int) {
            let indexPath = IndexPath(row: index, section: 0)
            leaguesTableView.reloadRows(at: [indexPath], with: .none)
        }
        
    
    func showError(message: String) {
        AppAlerts.showAlert(on: self, title: "Error", message: message)
        }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.leaguesTableView.alpha = 1
            let isDark = self.traitCollection.userInterfaceStyle == .dark
                   
                   let baseColor = isDark
                       ? UIColor(white: 0.2, alpha: 1)
                       : UIColor(white: 0.85, alpha: 1)
                   
                   let shimmerColor = isDark
                       ? UIColor(white: 0.3, alpha: 1)
                       : UIColor(white: 0.95, alpha: 1)
                   
                   let gradient = SkeletonGradient(baseColor: baseColor, secondaryColor: shimmerColor)
                   let animation = SkeletonAnimationBuilder()
                       .makeSlidingAnimation(withDirection: .leftRight, duration: 1.2)
                   
                   self.leaguesTableView.showAnimatedGradientSkeleton(
                       usingGradient: gradient,
                       animation: animation
                   )
               }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
                    self.leaguesTableView.hideSkeleton()
                }
    }
    
    func showDeleteConfirmation(for index: Int, leagueName: String) {
        AppAlerts.showConfirmation(
                on: self,
                title: "Remove From Favourite",
                message: "Are you sure you want to remove \(leagueName)?",
                confirmTitle: "Remove"
            ) { [weak self] in
                self?.presenter?.confirmRemoveFavorite(at: index)
            }
        }
    func showNoInternet() {
        AppAlerts.showNoInternet(on: self)
        }
    func navigateToLeagueDetails(with league: League,sport:String){
        
        guard let sport = presenter?.getSportType() else {return}
        guard let leagueDetailsScreen = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetails") as? LeagueDetailsCollectionViewController  else{
            return
        }
        leagueDetailsScreen.presenter = LeagueDetailsPresenter(view: leagueDetailsScreen, league: league ,sport:sport)
        
        self.navigationController?.pushViewController(leagueDetailsScreen, animated: true)
    }
}
