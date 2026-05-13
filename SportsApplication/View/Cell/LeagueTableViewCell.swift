//
//  LeagueTableViewCell.swift
//  SportsApplication
//
//  Created by Moaz on 07/05/2026.
//

import UIKit
import Kingfisher
class LeagueTableViewCell: UITableViewCell {
    @IBOutlet private var cardContainerView: UIView!
    @IBOutlet private var favButton: UIButton!
    @IBOutlet private var leagueCountryNameLabel: UILabel!
    @IBOutlet private var leagueCountryImageView: UIImageView!
    @IBOutlet private var leagueNameLabel: UILabel!
    @IBOutlet private var leagueImageView: UIImageView!
    
    var favAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardContainerView.layer.cornerRadius = 12
       
        cardContainerView.layer.masksToBounds = true
        
        leagueImageView.layer.cornerRadius = leagueImageView.frame.size.width / 2
        leagueCountryImageView.layer.cornerRadius = leagueCountryImageView.frame.size.width / 2
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
            isSkeletonable = true
            contentView.isSkeletonable = true
            cardContainerView.isSkeletonable = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func favTapped(_ sender: UIButton) {
        favAction?()
    }
    
    func configCell(forLeague league : League) {
        leagueNameLabel.text = league.leagueName
        leagueImageView.kf.setImage(
            with: URL(string:league.leagueLogo ?? ""),
                placeholder: UIImage(systemName: "photo.circle.fill"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheSerializer(FormatIndicatedCacheSerializer.png)
                ]
            )

        leagueCountryNameLabel.text = league.countryName
        leagueCountryImageView.kf.setImage(
            with: URL(string:league.countryLogo ?? ""),
                placeholder: UIImage(systemName: "photo.circle.fill" ),
                options: [
                    .transition(.fade(0.3)),
                    .cacheSerializer(FormatIndicatedCacheSerializer.png)
                ]
            )


        favButton.tintColor = league.isFav ? #colorLiteral(red: 0.9725490196, green: 0.4705882353, blue: 0.4431372549, alpha: 1) : #colorLiteral(red: 0.8012740016, green: 0.8012740016, blue: 0.8012740016, alpha: 1)
    }
    
}
