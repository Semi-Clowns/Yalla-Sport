//
//   LeagueDetailsCollectionViewController+ProtocolConform.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 11/05/2026.
//


import UIKit
import SkeletonView
// conform ViewProtocol extension
extension LeagueDetailsCollectionViewController : LeagueDetailsViewProtocol{
    func setLeagueTitle(title: String) {
        self.title = title
    }
    
    func updateFavoriteButtonState(isFavorite: Bool) {
        let color = isFavorite
                    ? #colorLiteral(red: 0.9725490196, green: 0.4705882353, blue: 0.4431372549, alpha: 1)
                    : #colorLiteral(red: 0.8012740016, green: 0.8012740016, blue: 0.8012740016, alpha: 1)
                
                navigationItem.rightBarButtonItem?.tintColor = color
    }
    
    func showDeleteAlert(leagueId: Int) {
        AppAlerts.showConfirmation(
                on: self,
                title: "Remove From Favourite",
                message: "Are you sure you want to remove this league?",
                confirmTitle: "Remove"
            ) { [weak self] in
                self?.presenter?.deleteConfirmation(leagueId: leagueId)
            }
        }
    
    func showError(message: String) {
        AppAlerts.showAlert(on: self, title: "Error", message: message)
        }
    
    func showLoading() {
        DispatchQueue.main.async {
            let baseColor = UIColor { trait in
                trait.userInterfaceStyle == .dark
                    ? UIColor(white: 0.2, alpha: 1)
                    : UIColor(white: 0.85, alpha: 1)
            }
            let shimmer = UIColor { trait in
                trait.userInterfaceStyle == .dark
                    ? UIColor(white: 0.3, alpha: 1)
                    : UIColor(white: 0.95, alpha: 1)
            }
            let gradient = SkeletonGradient(baseColor: baseColor, secondaryColor: shimmer)
                
                let animation = SkeletonAnimationBuilder()
                    .makeSlidingAnimation(withDirection: .leftRight, duration: 1.2)
                
            self.collectionView.showAnimatedGradientSkeleton(
                    usingGradient: gradient,
                    animation: animation
                )
            }
        
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
                    self.collectionView.hideSkeleton()
                }
    }
    
    private func checkAndShowEmptyState() {
        guard let presenter = presenter else { return }
        
        if presenter.isCompletelyEmpty() && !collectionView.sk.isSkeletonActive {
            let emptyView = UIView(frame: collectionView.bounds)
            
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 16
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let imageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle"))
            imageView.tintColor = .systemGray
            imageView.contentMode = .scaleAspectFit
            imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            
            let label = UILabel()
            label.text = "No data available for this league at the moment."
            label.textColor = .systemGray
            label.font = .systemFont(ofSize: 18, weight: .medium)
            label.textAlignment = .center
            label.numberOfLines = 0
            
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(label)
            emptyView.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 32),
                stackView.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -32)
            ])
            
            collectionView.backgroundView = emptyView
        } else {
            collectionView.backgroundView = nil
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.checkAndShowEmptyState()
                    self.collectionView.reloadData()
                }
    }
    
    
    
}
