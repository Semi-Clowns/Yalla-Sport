//
//  LeagueHeaderView.swift
//  SportsApplication
//
//  Created by Moaz on 09/05/2026.
//

import UIKit

final class LeagueHeaderView: UITableViewHeaderFooterView {

    static let identifier = "LeagueHeaderView"

    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Mushi-SemiBold", size: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    // MARK: - Configure
    func configure(title: String) {
        titleLabel.text = title
    }
}
