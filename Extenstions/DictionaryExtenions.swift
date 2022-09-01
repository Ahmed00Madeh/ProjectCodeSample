//
//  DictionaryExtenions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension Sequence where Iterator.Element == [String: Any] {
    var jsonString: String {
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: self,
            options: []
        ) {
            let theJSONText = String(data: theJSONData,
                                     encoding: .utf8)
            return theJSONText ?? ""
        }
        return ""
    }
}
