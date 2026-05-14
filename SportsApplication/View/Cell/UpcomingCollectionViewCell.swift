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
        contentView.layer.cornerRadius = 16
        
        roundView.clipsToBounds = true
        roundView.layer.cornerRadius = 6
        isSkeletonable = true
        contentView.isSkeletonable = true
    }

    func config(for event : Event) {

        homeTeamNameLabel.text = event.homeTeamName
        awayTeamNameLabel.text = event.awayTeamName

        
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: event.eventDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d/M"
            matchDateLabel.text = outputFormatter.string(from: date)
        }
        matchTimeLabel.text = event.eventTime
        matchOnRoundLabel.text = event.leagueRound ?? ""

        homeTeamImageView.kf.setImage(
            with: URL(string: event.homeTeamLogo ?? ""),
            placeholder: UIImage(named: "teamBadge")
        )

        awayTeamImageView.kf.setImage(
            with: URL(string: event.awayTeamLogo ?? ""),
            placeholder: UIImage(named: "teamBadge")
        )
    }
}
