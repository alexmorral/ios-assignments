//
//  Double+Extensions.swift
//  PizzaJeff
//
//  Created by Alex Morral on 12/2/21.
//

import Foundation


extension Double {
    func formatToEur() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_ES") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self))
    }
}
