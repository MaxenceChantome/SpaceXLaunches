//
//  LaunchCell.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import UIKit

struct LaunchCellViewData: Hashable {
    let missionName: String
    let rocketInfos: String
    let date: String
    let patchImage: URL?
    
    init(missionName: String, rocketInfos: String, date: String, patchImage: URL?) {
        self.missionName = missionName
        self.rocketInfos = rocketInfos
        self.date = date
        self.patchImage = patchImage
    }
}

class LaunchCell: UITableViewCell {
    private let missionNameLabel = UILabel(title: nil, font: .title, color: .white, lines: 0, alignment: .left)
    private let rocketInfosLabel =  UILabel(title: nil, font: .subtitle, color: .white, lines: 0, alignment: .left)
    private let dateLabel = UILabel(title: nil, font: .bodyMedium, color: .white, lines: 0, alignment: .right)
    private let patchImageView = UIImageView(contentMode: .scaleAspectFit)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews([missionNameLabel, rocketInfosLabel, dateLabel, patchImageView])
        
        patchImageView.bindConstraints([
            patchImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            patchImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            patchImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            patchImageView.widthAnchor.constraint(equalToConstant: 75)
        ])
        // fix autolayout constraint
        let constraint = patchImageView.heightAnchor.constraint(equalToConstant: 75)
        constraint.priority = .defaultHigh
        constraint.isActive = true

        
        missionNameLabel.bindConstraints([
            missionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            missionNameLabel.leftAnchor.constraint(equalTo: patchImageView.rightAnchor, constant: 16),
            missionNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        rocketInfosLabel.bindConstraints([
            rocketInfosLabel.topAnchor.constraint(equalTo: missionNameLabel.bottomAnchor, constant: 8),
            rocketInfosLabel.leftAnchor.constraint(equalTo: patchImageView.rightAnchor, constant: 16),
            rocketInfosLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        dateLabel.bindConstraints([
            dateLabel.leftAnchor.constraint(equalTo: patchImageView.rightAnchor, constant: 16),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        patchImageView.image = nil
        patchImageView.cancelImageLoad()
    }
    
    func configure(with data: LaunchCellViewData) {
        missionNameLabel.text = data.missionName
        rocketInfosLabel.text = data.rocketInfos
        dateLabel.text = data.date
        if let url = data.patchImage {
            patchImageView.loadImage(at: url)
        }
    }
}

