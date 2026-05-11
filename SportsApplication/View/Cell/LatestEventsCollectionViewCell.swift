//
//  LatestEventsCollectionViewCell.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 10/05/2026.
//

import UIKit
import Kingfisher
class LatestEventsCollectionViewCell: UICollectionViewCell {
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
        contentView.layer.cornerRadius = 6
        contentView.clipsToBounds = true
        
        
    }
    func configCell() {
          AwayTeamScore.text = "0"
          HomeTeamScore.text = "0"

          HomeTeamLogo.kf.setImage(
              with: URL(string:""),
                  placeholder: UIImage(systemName: "photo.circle.fill"),
                  options: [
                      .transition(.fade(0.3)),
                      .cacheSerializer(FormatIndicatedCacheSerializer.png)
                  ]
              )
          AwayTeamLogo.kf.setImage(
              with: URL(string:""),
                  placeholder: UIImage(systemName: "photo.circle.fill"),
                  options: [
                      .transition(.fade(0.3)),
                      .cacheSerializer(FormatIndicatedCacheSerializer.png)
                  ]
              )

          HomeTeamName.text = "Team"
          AwayTeamName.text = "Team"
          EventDate.text="15/4"



      }
    
    
    
    

}
