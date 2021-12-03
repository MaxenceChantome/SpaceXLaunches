//
//  SectionHeader.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 02/12/2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    private let titleLabel = UILabel(title: nil, font: .title, color: .text, lines: 0, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cardView = CardView()
        cardView.addSubview(titleLabel)
        addSubview(cardView)
        
        backgroundColor = .clear
        
        cardView.bindConstraintsToSuperview(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8))
        titleLabel.bindConstraintsToSuperview(UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        self.titleLabel.text = title
    }
}
