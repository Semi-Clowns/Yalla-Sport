//
//  TeamDetailsViewController.swift
//  SportsApplication
//
//  Created by Moaz on 11/05/2026.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController , TeamDetailsViewControllerProtocol {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var teamCountryLabel: UILabel!
    @IBOutlet var teamCountryLogoImageView: UIImageView!
    @IBOutlet var teamImageView: UIImageView!
    @IBOutlet var teamNameLabel: UILabel!
    var presenter : TeamDetailsPresenterProtocol? // Presenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        guard let team = presenter?.getTeamDetails() else {return}
        
        tableView.separatorStyle = .none
        
        teamImageView.kf.setImage(with: URL(string: team.teamLogo ?? ""),
                                  placeholder: UIImage(systemName: "photo.fill"))
        
        
        print(presenter?.getTeamDetails().teamLogo ?? "")
        
        teamImageView.layer.cornerRadius = teamImageView.frame.width / 2
        teamNameLabel.text = team.teamName
        
        teamCountryLabel.text = team.countryName?.uppercased()
        teamCountryLogoImageView.kf.setImage(with: URL(string: team.countryLogo ?? ""),
                                  placeholder: UIImage(systemName: "photo.fill"))
        teamCountryLogoImageView.layer.cornerRadius = teamCountryLogoImageView.frame.width / 2
        
        let nib = UINib(nibName: "PlayerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PlayerTableViewCell")
        let emptyNib = UINib(nibName: "EmptyStateTeamsCell", bundle: nil)
        tableView.register(emptyNib, forCellReuseIdentifier: "EmptyStateTeamsCell")
        if presenter?.isFullyEmpty() == true {
            showFullEmptyState()
        }
        setupTableHeader()
    }
    func showFullEmptyState() {
        tableView.isHidden = true

        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)

        let imageView = UIImageView(image: UIImage(systemName: "sportscourt"))
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "Team details will be available soon"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(imageView)
        container.addSubview(label)

        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

            imageView.topAnchor.constraint(equalTo: container.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    func setupTableHeader() {
        tableView.tableHeaderView = headerView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor)
        ])
        
        updateHeaderViewHeight()
    }
    
    func updateHeaderViewHeight() {
        guard let header = tableView.tableHeaderView else { return }
        
        let targetSize = CGSize(width: tableView.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let fittingSize = header.systemLayoutSizeFitting(targetSize,
                                                         withHorizontalFittingPriority: .required,
                                                         verticalFittingPriority: .fittingSizeLevel)
        
        if header.frame.size.height != fittingSize.height {
            header.frame.size.height = fittingSize.height
            tableView.tableHeaderView = header
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderViewHeight()
    }
}
