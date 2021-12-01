//
//  LaunchCell.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import UIKit

protocol LaunchCellViewDataProvider {
    var name: String { get }
}

struct LaunchCellViewData: LaunchCellViewDataProvider, Hashable {
    let name: String

    init(name: String) {
        self.name = name
    }
}

class LaunchCell: UITableViewCell {
    #warning("placeholder")
    private let nameLabel = UILabel(title: "Placeholder", font: .title, color: .red, lines: 0, alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        
        nameLabel.bindConstraintsToSuperview()
    }
    
    func configure(with data: LaunchCellViewDataProvider) {
        nameLabel.text = data.name
    }
}

