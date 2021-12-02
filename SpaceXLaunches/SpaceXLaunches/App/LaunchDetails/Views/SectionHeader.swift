//
//  SectionHeader.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 02/12/2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    private let titleLabel = UILabel(title: nil, font: .title, color: .white, lines: 0, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.bindConstraintsToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        self.titleLabel.text = title.uppercased()
    }
}
