//
//  AllLeaguesViewController.swift
//  SportsApplication
//
//  Created by Moaz on 09/05/2026.
//

import UIKit


protocol AllLeaguesViewControllerProtocol : AnyObject {
    func showLeagues(leagues: [League])
}

class AllLeaguesViewController: UIViewController , AllLeaguesViewControllerProtocol {

    @IBOutlet var leaguesTableView: UITableView!
    @IBOutlet var leaguesSearchBar: UISearchBar!
    
    
    
    var presenter : AllLeaguesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        leaguesSearchBar.delegate = self
        
        leaguesTableView.register(
            LeagueHeaderView.self,
            forHeaderFooterViewReuseIdentifier: LeagueHeaderView.identifier
        )
        
        
        
        leaguesTableView.rowHeight = UITableView.automaticDimension
        leaguesTableView.estimatedRowHeight = 80
        leaguesTableView.cellLayoutMarginsFollowReadableWidth = false

        presenter?.attachView(withView: self)
        print("View Controller Hello ")
        presenter?.loadLeagues()
        
        // register nib
        
        leaguesTableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagueTableViewCell")
        
        
        
        // search bar
//        leaguesSearchBar.layoutMargins = UIEdgeInsets(  top: 0, left: 0, bottom: 0, right: 0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension AllLeaguesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getLeaguesCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "LeagueTableViewCell",
            for: indexPath
        ) as? LeagueTableViewCell else {
            return UITableViewCell()
        }

        guard let league = presenter?.getLeagueAtIndex(at: indexPath.row) else {
            return cell
        }

        cell.configCell(forLeague: league)

        cell.favAction = { [weak self] in
            guard let self = self else { return }

            self.presenter?.toggleFavorite(at: indexPath.row)

            tableView.reloadRows(at: [indexPath], with: .none)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard section == 0 else { return nil }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: LeagueHeaderView.identifier
        ) as? LeagueHeaderView else {
            return nil
        }
        
        header.configure(title: "All Leagues")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 60 : 0
    }
    
    
}

extension AllLeaguesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filterData(searchText: searchText)
        leaguesTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



extension AllLeaguesViewController {
    func showLeagues(leagues: [League]) {
        leaguesTableView.reloadData()
    }
}
