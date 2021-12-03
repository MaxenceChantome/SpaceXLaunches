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
    private let missionNameLabel = UILabel(title: nil, font: .subtitle, color: .text, lines: 0, alignment: .left)
    private let infosLabel =  UILabel(title: nil, font: .caption, color: .lightText, lines: 0, alignment: .left)
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
        let cardView = CardView()
        let dataView = UIStackView(withDirection: .vertical, distribution: .fill, alignment: .fill, spacing: 4)
        
        dataView.addArrangedSubviews([missionNameLabel, infosLabel])
        contentView.addSubviews([cardView, dataView])
        cardView.addSubviews([patchImageView, dataView])
        
        patchImageView.bindConstraints([
            patchImageView.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 16),
            patchImageView.widthAnchor.constraint(equalToConstant: 50),
            patchImageView.heightAnchor.constraint(equalToConstant: 50),
            patchImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
        dataView.bindConstraints([
            dataView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            dataView.leftAnchor.constraint(equalTo: patchImageView.rightAnchor, constant: 16),
            dataView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -16),
            dataView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
        ])
        
        cardView.bindConstraintsToSuperview(UIEdgeInsets(top: 4, left: 20, bottom: -4, right: -20))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        patchImageView.image = nil
        patchImageView.cancelImageLoad()
    }
    
    func configure(with data: LaunchCellViewData) {
        missionNameLabel.text = data.missionName
        
        infosLabel.text = "\(data.rocketInfos) - \(data.date)"
        if let url = data.patchImage {
            patchImageView.loadImage(at: url)
        }
    }
}

