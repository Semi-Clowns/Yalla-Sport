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

    func config(for event : Event) {

        homeTeamNameLabel.text = event.homeTeamName
        awayTeamNameLabel.text = event.awayTeamName

        matchDateLabel.text = event.eventDate
        matchTimeLabel.text = event.eventTime
        matchOnRoundLabel.text = "35"

        homeTeamImageView.kf.setImage(
            with: URL(string: event.homeTeamLogo ?? ""),
            placeholder: UIImage(systemName: "photo.fill")
        )

        awayTeamImageView.kf.setImage(
            with: URL(string: event.awayTeamLogo ?? ""),
            placeholder: UIImage(systemName: "photo.fill")
        )
    }
}
