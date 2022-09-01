//
//  DateExtensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension Date {
    func string(
        format: String,
        identifier: Calendar.Identifier = .gregorian,
        locale: String = Language.currentLanguage.rawValue
    ) -> String {
        let formatter = DateFormatter.init(withFormat: format, locale: locale)
        formatter.calendar = Calendar(identifier: identifier)
        return formatter.string(from: self)
    }
}
