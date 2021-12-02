//
//  UIFont.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import UIKit

extension UIFont {
    class var title: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    class var subtitle: UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .semibold)
    }
    
    class var bodyMedium: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .medium)
    }
}
