//
//   LeagueDetailsCollectionViewController+ProtocolConform.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 11/05/2026.
//


import UIKit
// conform ViewProtocol extension
extension LeagueDetailsCollectionViewController : LeagueDetailsViewProtocol{
    func setLeagueTitle(title: String) {
        self.title = title
    }
    
    func updateFavoriteButtonState(isFavorite: Bool) {
        let color = isFavorite
                    ? #colorLiteral(red: 0.9725490196, green: 0.4705882353, blue: 0.4431372549, alpha: 1)
                    : #colorLiteral(red: 0.8012740016, green: 0.8012740016, blue: 0.8012740016, alpha: 1)
                
                navigationItem.rightBarButtonItem?.tintColor = color
    }
    
    func showDeleteAlert(leagueId: Int) {
        AppAlerts.showConfirmation(
                on: self,
                title: "Remove From Favourite",
                message: "Are you sure you want to remove this league?",
                confirmTitle: "Remove"
            ) { [weak self] in
                self?.presenter?.deleteConfirmation(leagueId: leagueId)
            }
        }
    
    func showError(message: String) {
        AppAlerts.showAlert(on: self, title: "Error", message: message)
        }
    
    func showLoading() {
        DispatchQueue.main.async {
            AppComponents.showLoading(on: self)
                }
        
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            AppComponents.hideLoading(on: self)
                }
    }
    
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
    }
    
    
    
}
