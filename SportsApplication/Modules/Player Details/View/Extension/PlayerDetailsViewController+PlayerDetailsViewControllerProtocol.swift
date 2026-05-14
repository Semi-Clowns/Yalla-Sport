//
//  PlayerDetailsViewController+PlayerDetailsViewControllerProtocol.swift
//  SportsApplication
//
//  Created by Moaz on 14/05/2026.
//

import UIKit


extension PlayerDetailsViewController: PlayerDetailsViewControllerProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}
