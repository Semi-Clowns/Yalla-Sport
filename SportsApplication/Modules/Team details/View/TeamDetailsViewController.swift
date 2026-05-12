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
    @IBOutlet var teamImageView: UIImageView!
    @IBOutlet var teamNameLabel: UILabel!
    var presenter : TeamDetailsPresenterProtocol? // Presenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup Presneter
//        presenter = TeamDetailsPresenter()
//        presenter?.attachView(with: self)
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableView.backgroundColor = .white
        guard let team = presenter?.getTeamDetails() else {return}
        tableView.separatorStyle = .none
        teamImageView.kf.setImage(with: URL(string: team.teamLogo ?? ""),
                                  placeholder: UIImage(systemName: "photo.fill"))
        
        
        print(presenter?.getTeamDetails().teamLogo ?? "")
        teamImageView.layer.cornerRadius = teamImageView.frame.width / 2
        teamNameLabel.text = team.teamName
//        teamCountryLabel.text = team.tea
        
        let nib = UINib(nibName: "PlayerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PlayerTableViewCell")
        
        setupTableHeader()
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

