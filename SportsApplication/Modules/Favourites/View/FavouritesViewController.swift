//
//  FavouritesViewController.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 09/05/2026.
//

import UIKit

final class FavouritesViewController: UITableViewController {
    
    var presenter: FavouritesPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarManager.setupMainNav(
                for: self,
                themeTarget: self,
                themeAction: #selector(themeButtonTapped)
            )
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            presenter?.fetchFavourites()
        NavigationBarManager.syncThemeIcon(for: self)

    }
    @objc private func themeButtonTapped() {
        NavigationBarManager.toggleTheme(for: self)

    }
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems(in: section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LeagueTableViewCell",
            for: indexPath) as! LeagueTableViewCell
        
        guard let league = presenter?.getLeague(at: indexPath) else {
                return cell
            }
        
        cell.configCell(forLeague: league)
        
        cell.favAction = { [weak self] in
            guard let self = self else { return }
            self.presenter?.deleteConfirmation(leagueId: league.id)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return presenter?.getSectionTitle(for: section)
    }
  
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let league = presenter?.getLeague(at: indexPath) else {
                    return
                }
            presenter?.deleteConfirmation(leagueId: league.id)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        presenter?.didSelectLeague(indexPath: indexPath)
    }
    
}


extension FavouritesViewController: FavouritesViewProtocol {
    
    func showFavourites() {
       
        DispatchQueue.main.async {
                self.tableView.backgroundView = nil
                self.tableView.reloadData()
            }
    }
    
    func showEmptyState() {
        DispatchQueue.main.async { [weak self] in
        let emptyLabel = UILabel()
        emptyLabel.text = "No Favourites Yet "
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .secondaryText
        emptyLabel.font = UIFont(name: "Mulish-Medium", size: 18)
            self?.tableView.backgroundView = emptyLabel
            self?.tableView.reloadData()
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
    
    func navigateToLeagueDetails(with league: League, sport:String) {
        guard let leagueDetailsScreen = self.storyboard?.instantiateViewController(
            withIdentifier: "LeagueDetails"
        ) as? LeagueDetailsCollectionViewController else {
            return
        }
        leagueDetailsScreen.presenter = LeagueDetailsPresenter(view: leagueDetailsScreen, league: league, sport: sport)
        self.navigationController?.pushViewController(leagueDetailsScreen, animated: true)
    }
    
}
