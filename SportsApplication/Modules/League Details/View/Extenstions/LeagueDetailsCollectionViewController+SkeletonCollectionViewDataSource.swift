//
//  LeagueDetailsCollectionViewController+SkeletonCollectionViewDataSource.swift
//  SportsApplication
//
//  Created by Moaz on 14/05/2026.
//

import UIKit
import SkeletonView

extension LeagueDetailsCollectionViewController: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        guard let section = LeagueSection(rawValue: indexPath.section) else { return "" }
        
        switch section {
        case .upcoming:     return "UpcomingCollectionViewCell"
        case .latestEvents: return "LatestEventsCollectionViewCell"
        case .teams:        return "TeamEventCollectionViewCell"
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let currentSection = LeagueSection(rawValue: section) else { return 0 }
        
        switch currentSection {
        case .upcoming:     return 3
        case .latestEvents: return 3
        case .teams:        return 3
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView,
        supplementaryViewIdentifierOfKind kind: String,
        at indexPath: IndexPath) -> ReusableCellIdentifier? {
        
        guard kind == UICollectionView.elementKindSectionHeader else { return nil }
        return "SectionHeaderView"
    }
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return presenter?.isTennis() == true ? 2 : 3
    }
}
