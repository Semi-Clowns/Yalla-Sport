//
//  AllLeaguesViewController+UITableViewDelegate.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import UIKit

extension AllLeaguesViewController: UITableViewDelegate {

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
        return 12
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToLeagueDetails(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
