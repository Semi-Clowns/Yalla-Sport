//
//  UpcomingCollectionViewCell.swift
//  SportsApplication
//
//  Created by Moaz on 10/05/2026.
//

import UIKit
import Kingfisher

class UpcomingCollectionViewCell: UICollectionViewCell {

   @IBOutlet private var homeTeamImageView: UIImageView!
    @IBOutlet private var homeTeamNameLabel: UILabel!

    @IBOutlet var roundView: UIView!
    @IBOutlet private var matchDateLabel: UILabel!
    @IBOutlet private var matchTimeLabel: UILabel!
    @IBOutlet private var matchOnRoundLabel: UILabel!

    @IBOutlet private var awayTeamImageView: UIImageView!
    @IBOutlet private var awayTeamNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 6
        
        roundView.clipsToBounds = true
        roundView.layer.cornerRadius = 6
    }

    func config(homeTeamName: String,
                homeTeamLogo: String?,
                awayTeamName: String,
                awayTeamLogo: String?,
                matchDate: String,
                matchTime: String,
                round: String) {

        homeTeamNameLabel.text = homeTeamName
        awayTeamNameLabel.text = awayTeamName

        matchDateLabel.text = matchDate
        matchTimeLabel.text = matchTime
        matchOnRoundLabel.text = round

        homeTeamImageView.kf.setImage(
            with: URL(string: homeTeamLogo ?? "https://apiv2.allsportsapi.com/logo/80_manchester-city.jpg"),
            placeholder: UIImage(systemName: "photo")
        )

        awayTeamImageView.kf.setImage(
            with: URL(string: awayTeamLogo ?? "https://apiv2.allsportsapi.com/logo/80_manchester-city.jpg"),
            placeholder: UIImage(systemName: "photo")
        )
    }
}
