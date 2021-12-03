//
//  UIButton.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 02/12/2021.
//

import UIKit

public extension UIButton {
    convenience init(title: String, font: UIFont, textColor: UIColor, backgroundColor: UIColor) {
        self.init(type: .roundedRect)
        tintColor = backgroundColor
        var configuration = UIButton.Configuration.filled() // 1
        var container = AttributeContainer()
        container.font = font
        configuration.attributedTitle = AttributedString(title, attributes: container)
        configuration.background.cornerRadius = 25
        configuration.baseForegroundColor = textColor
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20)
        self.configuration = configuration
    }
}
