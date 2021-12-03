//
//  CardView.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 03/12/2021.
//

import UIKit

class CardView: UIView {
    init() {
        super.init(frame: .zero)
        
        cornerRadius = 12
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
