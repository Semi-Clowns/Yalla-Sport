//
//  AllLeaguesViewController.swift
//  SportsApplication
//
//  Created by Moaz on 09/05/2026.
//

import UIKit

import SkeletonView

class AllLeaguesViewController: UIViewController {
    @IBOutlet var leaguesTableView: UITableView!
    @IBOutlet var leaguesSearchBar: UISearchBar!
    
    
    
    var presenter : AllLeaguesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        leaguesSearchBar.delegate = self
        leaguesTableView.isSkeletonable = true
        leaguesTableView.register(
            LeagueHeaderView.self,
            forHeaderFooterViewReuseIdentifier: LeagueHeaderView.identifier
        )
        
        leaguesTableView.rowHeight = UITableView.automaticDimension
        leaguesTableView.estimatedRowHeight = 130
        leaguesTableView.cellLayoutMarginsFollowReadableWidth = false

        presenter?.attachView(withView: self)
        print("View Controller Hello ")
        presenter?.loadLeagues()
        
        // register nib
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        leaguesTableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagueTableViewCell")

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadLeagues()
    }

}
