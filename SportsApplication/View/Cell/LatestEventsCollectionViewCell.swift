//
//  LatestEventsCollectionViewCell.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 10/05/2026.
//

import UIKit
import Kingfisher
class LatestEventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var AwayTeamScore: UILabel!
    @IBOutlet weak var HomeTeamScore: UILabel!
    @IBOutlet weak var AwayTeamName: UILabel!
    @IBOutlet weak var HomeTeamName: UILabel!
    @IBOutlet weak var AwayTeamLogo: UIImageView!
    @IBOutlet weak var HomeTeamLogo: UIImageView!
    @IBOutlet weak var EventDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        
  
        isSkeletonable = true
        contentView.isSkeletonable = true
        
        
    }
    func configCell(for event : Event) {
        let scores = getScores(from: event.finalResult ?? "0 - 0")
        AwayTeamScore.text = scores.home
        HomeTeamScore.text = scores.away

          HomeTeamLogo.kf.setImage(
            with: URL(string:event.homeTeamLogo ?? ""),
                  placeholder: UIImage(named: "teamBadge"),
                  options: [
                      .transition(.fade(0.3)),
                      .cacheSerializer(FormatIndicatedCacheSerializer.png)
                  ]
              )
          AwayTeamLogo.kf.setImage(
            with: URL(string:event.awayTeamLogo ?? ""),
                  placeholder: UIImage(named: "teamBadge"),
                  options: [
                      .transition(.fade(0.3)),
                      .cacheSerializer(FormatIndicatedCacheSerializer.png)
                  ]
              )

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: event.eventDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d/M"
            EventDate.text = outputFormatter.string(from: date)
        }
        
        HomeTeamName.text = event.homeTeamName
        AwayTeamName.text = event.awayTeamName



      }
    
    
    
    private func getScores(from result: String) -> (home: String, away: String) {
        let parts = result.split(separator: "-")
        let away = parts.first?.trimmingCharacters(in: .whitespaces) ?? ""
        let home = parts.count > 1 ? parts[1].trimmingCharacters(in: .whitespaces) : ""
        return (home, away)
    }

}
