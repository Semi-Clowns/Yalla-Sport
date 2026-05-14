//
//  PlayerTableViewCell.swift
//  SportsApplication
//
//  Created by Moaz on 11/05/2026.
//

import UIKit
import Kingfisher

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet private var playerTypeLabel: UILabel!
    @IBOutlet private var playerNameLabel: UILabel!
    @IBOutlet private var tshirtNumberPlayerLabel: UILabel!
    @IBOutlet private var playerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        playerImageView.layer.cornerRadius = playerImageView.frame.size.width / 2

        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        isSkeletonable = true
        contentView.isSkeletonable = true
        containerView.isSkeletonable = true
    }

    func configCell(for player: Player) {
        let placeHolder : String!
       
        if player.playerType == .coach{
            placeHolder =  "coach"
        }
        else{
            placeHolder = "playerPlaceholder"
        }
        
        playerNameLabel.text = player.playerName
        playerTypeLabel.text = player.playerType.rawValue
        
        playerTypeLabel.textColor = player.playerType.badgeColor

        tshirtNumberPlayerLabel.text = player.playerNumber?.isEmpty == false ? player.playerNumber : "-"
        playerImageView.kf.setImage(
            with: URL(string: player.playerImage ?? ""),
            placeholder: UIImage(named: placeHolder)
        )
    }
}
