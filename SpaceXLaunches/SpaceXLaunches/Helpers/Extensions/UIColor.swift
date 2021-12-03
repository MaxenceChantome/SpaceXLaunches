//
//  UIColor.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 30/11/2021.
//

import Foundation
import UIKit

extension UIColor {
    static var gradient: [UIColor] {
        return [#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1), #colorLiteral(red: 0.862745098, green: 0.8862745098, blue: 0.9607843137, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)]
    }
    
    static var primary: UIColor {
       return  #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    }
    
    static var text: UIColor {
       return  #colorLiteral(red: 0.0862745098, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
    }
    
    static var lightText: UIColor {
       return  #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
    }
    
}
