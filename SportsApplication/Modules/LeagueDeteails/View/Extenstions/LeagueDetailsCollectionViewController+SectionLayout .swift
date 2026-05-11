//
//  LeagueDetailsCollectionViewController+SectionLayout .swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 11/05/2026.
//

import UIKit
// Sections layout extension
extension LeagueDetailsCollectionViewController {
    
    func setupCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            
            guard let section = LeagueSection(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .upcoming:
                return self?.drawUpcomingSection()
            case .latestEvents:
                return self?.drawLatestEventsSection()
            case .teams:
                return self?.drawTeamsSection()
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func drawUpcomingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            let containerWidth = environment.container.contentSize.width
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - containerWidth / 2.0)
                let minScale: CGFloat = 0.85
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / containerWidth), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        section.boundarySupplementaryItems = [createSectionHeader()]
        return section
    }
    func drawLatestEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [createSectionHeader()]
        return section
    }
    
    func drawTeamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.32), heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [createSectionHeader()]
        
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return sectionHeader
    }
}
