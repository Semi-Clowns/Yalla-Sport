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
        return section == 0 ? presenter?.getTeamCoachCount() ?? 0 : presenter?.getTeamPlayersCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as? PlayerTableViewCell else { return UITableViewCell() }

        if indexPath.section == 0 {
            guard let coach = presenter?.getCoach() else { return UITableViewCell() }
            cell.configCell(for: coach.asPlayer())
        } else {
            guard let player = presenter?.getPlayerAtIndex(at: indexPath.row) else { return UITableViewCell() }
            cell.configCell(for: player)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Coach" : "Players"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .primaryText
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            guard let selectedCoach = presenter?.getCoach() else { return }
            
            guard !selectedCoach.coachName.isEmpty else {
                AppAlerts.showNoData(on: self, for: selectedCoach.coachName)
                return
            }
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerDetailsView") as! PlayerDetailsViewController
            vc.presenter = PlayerDetailsPresenter(player: selectedCoach.asPlayer())
            navigationController?.pushViewController(vc, animated: true)
        } else {
            guard let selectedPlayer = presenter?.getPlayerAtIndex(at: indexPath.row) else { return }
            
            guard !selectedPlayer.playerName.isEmpty else {
                AppAlerts.showNoData(on: self, for: selectedPlayer.playerName)
                return
            }
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerDetailsView") as! PlayerDetailsViewController
            vc.presenter = PlayerDetailsPresenter(player: selectedPlayer)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
