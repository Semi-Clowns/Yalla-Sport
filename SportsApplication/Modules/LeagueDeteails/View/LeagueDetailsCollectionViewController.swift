//
//  LeagueDetailsCollectionViewController.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 11/05/2026.
//

import UIKit

class LeagueDetailsCollectionViewController: UICollectionViewController {
    var presenter: LeagueDetailsPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let currentSection = LeagueSection(rawValue: section) else { return 0 }
                
                switch currentSection {
                case .upcoming:
                    return presenter?.getUpcomingEventsCount() ?? 0
                case .latestEvents:
                    return presenter?.getLatestEventsCount() ?? 0
                case .teams:
                    return presenter?.getTeamsCount() ?? 0
                }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let currentSection = LeagueSection(rawValue: indexPath.section) else {
                    return UICollectionViewCell()
                }
                
                switch currentSection {
                case .upcoming:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCollectionViewCell", for: indexPath) as? UpcomingCollectionViewCell else{
                        return UICollectionViewCell()
                    }
                    //let event = presenter?.getUpcomingEvent(at: indexPath.row)
                    
                  // cell.configCell()
                     return cell
                    
                case .latestEvents:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventsCollectionViewCell", for: indexPath) as? LatestEventsCollectionViewCell else{
                        return UICollectionViewCell()
                    }
                    
                   // let event = presenter?.getLatestEvent(at: indexPath.row)
                     cell.configCell()
                    return cell
                    
                case .teams:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamEventCollectionViewCell", for: indexPath) as? TeamEventCollectionViewCell else{
                        return UICollectionViewCell()

                    }
                    //let team = presenter?.getTeam(at: indexPath.row)
                    cell.delegate = self
                    cell.configCell()
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
