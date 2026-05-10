//
//  FavouritesViewController.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 09/05/2026.
//

import UIKit

final class FavouritesViewController: UITableViewController {
    
    var presenter: FavouritesPresenterProtocol?
    private var favourites: [[League]] = []
    private var sectionTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavouritesPresenter(view: self)
        tableView.register(
            UINib(nibName: "LeagueTableViewCell", bundle: nil),
            forCellReuseIdentifier: "LeagueTableViewCell"
        )
        presenter?.fetchFavourites()

        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
    
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return favourites[section].count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LeagueTableViewCell",
            for: indexPath) as! LeagueTableViewCell
        
        let league = favourites[indexPath.section][indexPath.row]
        cell.configCell(forLeague: league)
        
        cell.favAction = { [weak self] in
            guard let self = self else { return }
            self.presenter?.deleteConfirmation(leagueId: league.id)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
  
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let leagueId = favourites[indexPath.section][indexPath.row].id
            presenter?.deleteConfirmation(leagueId: leagueId)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let league = favourites[indexPath.section][indexPath.row]
        presenter?.didSelectLeague(leagueId: league.id,sportType: league.sportType ?? "other")
    }
    
}


extension FavouritesViewController: FavouritesViewProtocol {
    
    func showFavourites(leagues: [[League]], sections: [String]) {
        favourites = leagues
        sectionTitles = sections
        tableView.backgroundView = nil
        tableView.reloadData()
    }
    
    func showEmptyState() {
        favourites = []
        sectionTitles = []
        let emptyLabel = UILabel()
        emptyLabel.text = "No Favourites Yet ⭐"
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .secondaryText
        emptyLabel.font = UIFont(name: "Mulish-Medium", size: 18)
        tableView.backgroundView = emptyLabel
        tableView.reloadData()
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
    
    func showDeleteAlert(leagueId: Int) {
        AppAlerts.showConfirmation(
                on: self,
                title: "Remove From Favourite",
                message: "Are you sure you want to remove this league?",
                confirmTitle: "Remove"
            ) { [weak self] in
                self?.presenter?.removeFavourite(leagueId: leagueId)
            }
        }
    func showNoInternet() {
        AppAlerts.showNoInternet(on: self)
        }
}
