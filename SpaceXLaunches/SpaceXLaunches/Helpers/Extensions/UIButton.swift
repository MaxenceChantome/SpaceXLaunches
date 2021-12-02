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
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.titleLabel?.tintColor = textColor
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(title, for: .normal)
    }
}
