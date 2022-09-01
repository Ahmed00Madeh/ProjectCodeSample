//
//  Language.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

let APPLE_LANGUAGE_KEY = "AppleLanguages"

class Language: NSObject {
    
    static var currentLanguage : AppLanguage {
        var langStr = "en"
        if let lang = Cache.object(key: "currentLang") as? String {
            langStr = lang
        }
        return AppLanguage.init(rawValue: langStr) ?? .arabic
    }

    static func setCurrentLanguage(lang : AppLanguage) {
        Cache.set(object: lang.rawValue, forKey: "currentLang")
    }
    
    class var isArabic: Bool {
        return Language.currentLanguage == .arabic
    }
    
    static func switchLange() {
        setCurrentLanguage(lang: isArabic ? .english : .arabic)
    }
}

enum AppLanguage : String {
    case arabic = "ar"
    case english = "en"
}
