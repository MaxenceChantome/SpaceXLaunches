//
//  Date.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import Foundation

enum DateFormat: String {
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
    case dayAndYear = "MM-dd-yyyy"
}

extension Date {
    func string(withFormat format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        return formatter.string(from: self)
    }
}

