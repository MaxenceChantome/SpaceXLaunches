//
//  Date.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import Foundation

extension Date {
    func string(with style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = style
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
    
   
}

