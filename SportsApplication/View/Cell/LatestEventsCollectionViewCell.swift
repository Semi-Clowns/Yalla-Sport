//
//  LatestEventsCollectionViewCell.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 10/05/2026.
//

import UIKit

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
    
    
    
    

}
