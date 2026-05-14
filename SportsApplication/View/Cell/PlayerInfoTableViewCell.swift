//
//  PlayerInfoTableViewCell.swift
//  SportsApplication
//
//  Created by Moaz on 13/05/2026.
//

import UIKit
import Kingfisher

class PlayerInfoTableViewCell: UITableViewCell {

    @IBOutlet private var infoValueLabel: UILabel!
    @IBOutlet private var infoImageView: UIImageView!
    @IBOutlet private var infoTitleLabel: UILabel!
    
    @IBOutlet var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoImageView.layer.cornerRadius = infoImageView.frame.width / 2
        
        containerView.layer.cornerRadius = 32
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(
        infoTitle: String,
        infoImage: String?,
        infoValue: String?
    ) {
        infoTitleLabel.text = infoTitle
        if infoImage != nil {
            infoImageView.kf.setImage(with: URL(string: infoImage ?? "" ),
                                      placeholder: UIImage(named: "teamBadge"))
        } else {
            infoImageView.isHidden = true
        }
       
        infoValueLabel.text = infoValue
    }
    
}
