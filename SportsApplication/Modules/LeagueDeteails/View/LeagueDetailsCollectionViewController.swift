//
//  LeagueDetailsCollectionViewController.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 11/05/2026.
//

import UIKit
import SkeletonView
class LeagueDetailsCollectionViewController: UICollectionViewController {
    var presenter: LeagueDetailsPresenterProtocol?
    
    var currentIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isSkeletonable = true

       registerCells()
        setupCompositionalLayout()
        setupNavigationBar()
        presenter?.viewDidLoad()
        
    }
    
    
    func registerCells(){
        let upcomingNib = UINib(nibName: "UpcomingCollectionViewCell", bundle: nil)
                collectionView.register(upcomingNib, forCellWithReuseIdentifier: "UpcomingCollectionViewCell")
        let latestEventsNib = UINib(nibName: "LatestEventsCollectionViewCell", bundle: nil)
                collectionView.register(latestEventsNib, forCellWithReuseIdentifier: "LatestEventsCollectionViewCell")
        let teamEventNib = UINib(nibName: "TeamEventCollectionViewCell", bundle: nil)
                collectionView.register(teamEventNib, forCellWithReuseIdentifier: "TeamEventCollectionViewCell")
        collectionView.register(SectionHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: "SectionHeaderView")
        collectionView.register(EmptyStateCell.self, forCellWithReuseIdentifier: "EmptyStateCell")
    }
    func setupNavigationBar() {
            navigationController?.navigationBar.tintColor = .primaryColor
            let favButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(favButtonTapped))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                        style: .plain,
                                        target: self ,
                                         action: #selector(backButtonTapped))
            navigationItem.rightBarButtonItem = favButton
        navigationItem.leftBarButtonItem = backButton
             
        }
        
    @objc private func favButtonTapped() {
        presenter?.toggleFavorite()
    }
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
  

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let presenter = presenter else { return 0 }
        
        
        if presenter.isCompletelyEmpty() && !collectionView.sk.isSkeletonActive {
                    return 0
                }
        return presenter.isTennis() ? 2 : 3
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let currentSection = LeagueSection(rawValue: section) else{ return 0 }
        guard   let presenter = presenter else { return 0 }
        
        
        if presenter.isCompletelyEmpty() && !collectionView.sk.isSkeletonActive {
                    return 0
                }
        
        switch currentSection {
        case .upcoming:
            return presenter.isUpcomingEmpty() ? 1 : presenter.getUpcomingEventsCount()
        case .latestEvents:
            return presenter.isLatestEmpty() ? 1 : presenter.getLatestEventsCount()
        case .teams:
            return presenter.isTeamsEmpty() ? 1 : presenter.getTeamsCount()
        }
    }

   

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let currentSection = LeagueSection(rawValue: indexPath.section) else {
                    return UICollectionViewCell()
                }
        guard let presenter = presenter else { return UICollectionViewCell() }
                switch currentSection {
                case .upcoming:
                    if presenter.isUpcomingEmpty() {
                                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateCell
                                cell.messageLabel.text = "No upcoming matches scheduled."
                                return cell
                            }
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCollectionViewCell", for: indexPath) as? UpcomingCollectionViewCell else{
                        return UICollectionViewCell()
                    }
                     let event = presenter.getUpcomingEvent(at: indexPath.row)
                    
                    cell.config(for: event)
                     return cell
                    
                case .latestEvents:
                    if presenter.isLatestEmpty() {
                                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateCell
                                cell.messageLabel.text = "No recent match results available."
                                return cell
                            }
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventsCollectionViewCell", for: indexPath) as? LatestEventsCollectionViewCell else{
                        return UICollectionViewCell()
                    }
                    
                     let event = presenter.getLatestEvent(at: indexPath.row)
                 cell.configCell(for: event)
                    return cell
                    
                case .teams:
                    if presenter.isTeamsEmpty() {
                                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateCell
                                cell.messageLabel.text = "Team data is currently unavailable."
                                return cell
                            }
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamEventCollectionViewCell", for: indexPath) as? TeamEventCollectionViewCell else{
                        return UICollectionViewCell()

                    }
                     let team = presenter.getTeam(at: indexPath.row)
                //    self.currentIndex = indexPath.row
                    cell.delegate = self
                    
                    cell.configCell(for: team)
                    return cell
                }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as? SectionHeaderView else {
           return UICollectionReusableView()
        }
        guard let currentSection = LeagueSection(rawValue: indexPath.section) else { return header}

        switch currentSection {
            case .upcoming:
                header.titleLabel.text = "Upcoming Matches"
            case .latestEvents:
                header.titleLabel.text = "Latest Results"
            case .teams:
                header.titleLabel.text = "Teams"
            }
            
            return header
    
    }
    
    
    

}
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
