//
//  File.swift
//  SportsApplication
//
//  Created by Moaz on 11/05/2026.
//

import UIKit

extension LeagueDetailsCollectionViewController: TeamEventCellDelegate {
    func didTeam(_ cell: TeamEventCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell),
              let team = presenter?.getTeam(at: indexPath.item) else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TeamDetailsView") as? TeamDetailsViewController else { return }

        vc.presenter = TeamDetailsPresenter(team: team)
        vc.presenter?.attachView(with: vc)

        navigationController?.pushViewController(vc, animated: true)
    }
}
