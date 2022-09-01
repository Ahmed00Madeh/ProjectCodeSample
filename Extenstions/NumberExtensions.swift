//
//  NumberExtensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension Int {
    func string(style: NumberFormatter.Style = .none) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: Language.currentLanguage.rawValue)
        formatter.numberStyle = style
        formatter.maximumFractionDigits = 0
        let number = NSNumber.init(value: self)
        return formatter.string(from: number) ?? ""
    }
}

extension Float {
    func string(style: NumberFormatter.Style) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: Language.currentLanguage.rawValue)
        formatter.numberStyle = style
        formatter.maximumFractionDigits = 2
        let number = NSNumber.init(value: self)
        return formatter.string(from: number) ?? ""
    }
}

extension Double {
    func string(style: NumberFormatter.Style) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: Language.currentLanguage.rawValue)
        formatter.numberStyle = style
        formatter.maximumFractionDigits = 2
        let number = NSNumber.init(value: self)
        return formatter.string(from: number) ?? ""
    }
}
