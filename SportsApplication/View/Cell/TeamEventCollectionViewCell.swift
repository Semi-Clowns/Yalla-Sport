//
//  TeamEventCollectionViewCell.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 10/05/2026.
//

import UIKit

class TeamEventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var TeamLogo: UIImageView!
    
    @IBOutlet weak var TeamName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 6
        contentView.backgroundColor = .primaryColor
    }

    @IBAction func GoToDetails(_ sender: Any) {
        // navgation to team details screen with team id
    }
    func configCell() {
        TeamLogo.kf.setImage(
            with: URL(string:""),
                placeholder: UIImage(systemName: "photo.circle.fill"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheSerializer(FormatIndicatedCacheSerializer.png)
                ]
            )
        TeamName.text = "Manchester United"
        
    }
}
