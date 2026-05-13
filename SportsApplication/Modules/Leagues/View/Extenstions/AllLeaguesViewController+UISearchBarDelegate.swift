//
//  AllLeaguesViewController+UISearchBarDelegate.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import UIKit

extension AllLeaguesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filterData(searchText: searchText)
        leaguesTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
