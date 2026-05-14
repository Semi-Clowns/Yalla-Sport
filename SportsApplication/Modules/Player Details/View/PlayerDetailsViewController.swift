//
//  PlayerDetailsViewController.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import UIKit

protocol PlayerDetailsViewControllerProtocol : AnyObject{
    func reloadData()
}

class PlayerDetailsViewController: UIViewController {

    @IBOutlet var playerImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
        
    var presenter: PlayerDetailsPresenterProtocol!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setupUI()
           setupTableView()
           presenter.attachView(with: self)
       }
       
       private func setupUI() {
           let player = presenter.getPlayer()
           title = player.playerName
           
           playerImageView.layer.cornerRadius = 12
           
           playerImageView.kf.setImage(
               with: URL(string: player.playerImage ?? ""),
               placeholder: UIImage(systemName: "person.fill")
           )
       }
       
       private func setupTableView() {
           tableView.delegate = self
           tableView.dataSource = self
           tableView.register(
               UINib(nibName: "PlayerInfoTableViewCell", bundle: nil),
               forCellReuseIdentifier: "PlayerInfoTableViewCell"
           )
           tableView.separatorStyle = .none
           tableView.showsVerticalScrollIndicator = false
       }
   }
