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
    private let valueLabel = UILabel(title: nil, font: .title, color: .white, lines: 0, alignment: .center)
    private let infoLabel = UILabel(title: nil, font: .bodyMedium, color: .lightGray, lines: 0, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .dark
        cornerRadius = 12
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews([valueLabel, infoLabel])
        
        valueLabel.bindConstraints([
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
        ])
        infoLabel.bindConstraints([
            infoLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 8),
            infoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            infoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with data: RocketDetailsCellViewData) {
        valueLabel.text = data.value
        infoLabel.text = data.detail
    }
}
