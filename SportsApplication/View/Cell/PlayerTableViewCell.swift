//
//  PlayerTableViewCell.swift
//  SportsApplication
//
//  Created by Moaz on 11/05/2026.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet private var playerTypeLabel: UILabel!
    @IBOutlet private var playerNameLabel: UILabel!
    @IBOutlet private var tshirtNumberPlayerLabel: UILabel!
    @IBOutlet private var playerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        playerImageView.layer.cornerRadius = playerImageView.frame.size.width / 2
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    func configCell(for player: Player) {
        playerNameLabel.text = player.playerName
        playerTypeLabel.text = player.playerType.rawValue
        tshirtNumberPlayerLabel.text = player.playerNumber?.isEmpty == false ? player.playerNumber : "-"
        playerImageView.kf.setImage(
            with: URL(string: player.playerImage ?? ""),
            placeholder: UIImage(systemName: "person.fill")
        )
    }
}
