//
//  RocketDetailsCell.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 02/12/2021.
//

import UIKit

struct RocketDetailsCellViewData: Hashable {
    let value: String
    let detail: String
    
    init(value: String, detail: String) {
        self.value = value
        self.detail = detail
    }
}

class RocketDetailsCell: UICollectionViewCell {
    private let valueLabel = UILabel(title: nil, font: .title, color: .text, lines: 0, alignment: .center)
    private let infoLabel = UILabel(title: nil, font: .caption, color: .lightText, lines: 0, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        cornerRadius = 12
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let containerView = UIView(backgroundColor: .clear)
        containerView.addSubviews([valueLabel, infoLabel])
        contentView.addSubview(containerView)
    
        valueLabel.bindConstraints([
            valueLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            valueLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            valueLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
        infoLabel.bindConstraints([
            infoLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            infoLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            infoLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        containerView.bindConstraints([
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with data: RocketDetailsCellViewData) {
        valueLabel.text = data.value
        infoLabel.text = data.detail
    }
}
