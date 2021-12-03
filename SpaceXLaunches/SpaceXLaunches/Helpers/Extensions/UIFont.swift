//
//  UIFont.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import UIKit

extension UIFont {
    class var title: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    
    class var subtitle: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    class var body: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    class var caption: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .medium)
    }
}
