//
//  AllLeaguesViewController+SkeletonTableViewDataSource.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import UIKit
import SkeletonView

extension AllLeaguesViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
            return "LeagueTableViewCell"
    }
}
