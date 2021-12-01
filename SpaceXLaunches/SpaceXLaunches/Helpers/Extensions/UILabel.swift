//
//  UILabel.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import UIKit

extension UILabel {
    convenience init(title: String? = nil, font: UIFont, color: UIColor, lines: Int = 1, alignment: NSTextAlignment? = nil) {
        self.init()
        self.text = title
        if let alignment = alignment {
            self.textAlignment = alignment
        }
        self.font = font
        self.textColor = color
        self.numberOfLines = lines
    }
}
