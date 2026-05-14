//
//  PlayerDetailsViewController+UITableView.swift
//  SportsApplication
//
//  Created by Moaz on 14/05/2026.
//

import UIKit


extension PlayerDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getInfoRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PlayerInfoTableViewCell",
            for: indexPath
        ) as? PlayerInfoTableViewCell else { return UITableViewCell() }
        
        let row = presenter.getInfoRowsAtIndex(at: indexPath.row)
        cell.config(infoTitle: row.title, infoImage: row.imageURL, infoValue: row.value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
