//
//  Int+Double.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 03/12/2021.
//

import Foundation

extension Int {
    func formattedCurrency() -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 0
        currencyFormatter.currencySymbol = "$"
        return currencyFormatter.string(from: NSNumber(value: self))
    }
    
    func formattedMass() -> String? {
        let massFormatter = MassFormatter()
        massFormatter.unitStyle = .medium
        return massFormatter.string(fromKilograms: Double(self))
    }
}

extension Double {
    func formattedLength() -> String? {
        let formatter = LengthFormatter()
        return formatter.string(fromMeters: self)
    }
}

