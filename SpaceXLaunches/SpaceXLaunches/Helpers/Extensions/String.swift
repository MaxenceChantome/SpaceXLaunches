//
//  String.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import Foundation

enum DateFormat: String {
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
}

extension String {
    public func iso8601Date() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.iso8601.rawValue
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        return formatter.date(from: self)
    }
}
