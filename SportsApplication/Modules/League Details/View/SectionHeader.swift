//
//  SectionHeader.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 11/05/2026.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Mulish-Medium", size: 18)
        titleLabel.textColor = .primaryText
        isSkeletonable = true
        titleLabel.isSkeletonable = true
        titleLabel.linesCornerRadius = 4
        titleLabel.lastLineFillPercent = 40
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
