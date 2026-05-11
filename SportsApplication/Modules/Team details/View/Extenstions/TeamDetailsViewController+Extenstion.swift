//
//  TeamDetailsViewController+Extenstion.swift
//  SportsApplication
//
//  Created by Moaz on 11/05/2026.
//

import UIKit

extension TeamDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : presenter?.getTeamPlayersCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as? PlayerTableViewCell else { return UITableViewCell() }

        guard let team = presenter?.getTeamDetails() else {return UITableViewCell()}
        if indexPath.section == 0 {
            cell.configCell(playerName: team.coachName, playerType: "Coach", tshirtNumber: nil, playerImageURL: nil)
        } else {
            cell.configCell(playerName: presenter?.getPlayerAtIndex(at: indexPath.row).name ?? "" , playerType: presenter?.getPlayerAtIndex(at: indexPath.row).position ?? "", tshirtNumber: nil, playerImageURL: nil)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Coach" : "Players"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 90 : 80
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .white
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            header.tintColor = .clear
        }
    }
}
