//
//  RocketDetailsCell.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 02/12/2021.
//

import UIKit

struct RocketDetailsCellViewData: Hashable {
    let detail: String
    
    init(detail: String) {
        self.detail = detail
    }
}

class RocketDetailsCell: UICollectionViewCell {
    private let missionNameLabel = UILabel(title: nil, font: .title, color: .white, lines: 0, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(missionNameLabel)
        
        missionNameLabel.bindConstraintsToSuperview()
    }
    
    func configure(with data: RocketDetailsCellViewData) {
        missionNameLabel.text = data.detail
    }
}
