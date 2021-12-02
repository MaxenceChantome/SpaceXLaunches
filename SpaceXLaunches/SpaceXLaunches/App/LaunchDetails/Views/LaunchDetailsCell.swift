//
//  LaunchDetailsCell.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 02/12/2021.
//

import UIKit

struct MissionDetailsCellViewData: Hashable {
    let name: String
    let description: String
    let site: String
    let date: String
    
    init(name: String, description: String, site: String, date: String) {
        self.name = name
        self.description = description
        self.site = site
        self.date = date
    }
}

class MissionDetailsCell: UICollectionViewCell {
    private let nameLabel = UILabel(title: nil, font: .title, color: .white, lines: 0, alignment: .left)
    private let siteLabel = UILabel(title: nil, font: .title, color: .white, lines: 0, alignment: .left)
    private let descriptionLabel = UILabel(title: nil, font: .bodyMedium, color: .white, lines: 0, alignment: .left)
    private let dateLabel = UILabel(title: nil, font: .bodyMedium, color: .white, lines: 0, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews([nameLabel, siteLabel, dateLabel, descriptionLabel])
        
        nameLabel.bindConstraints([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        siteLabel.bindConstraints([
            siteLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            siteLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            siteLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
        dateLabel.bindConstraints([
            dateLabel.topAnchor.constraint(equalTo: siteLabel.bottomAnchor, constant: 8),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
        descriptionLabel.bindConstraints([
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with data: MissionDetailsCellViewData) {
        nameLabel.text = data.name
        descriptionLabel.text = data.description
        dateLabel.text = data.date
        siteLabel.text = data.site
    }
}
