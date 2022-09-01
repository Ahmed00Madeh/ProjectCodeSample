//
//  UIFontExensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UIFont {
    
    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    static func appFont(ofSize size: CGFloat, weight: Weight) -> UIFont? {
        return UIFont.systemFont(ofSize: size, weight: weight).appFont()
    }
    
    func appFont() -> UIFont? {
        switch weight {
        case .black, .bold:
            return .init(name: "Tajawal-Bold", size: pointSize)
        case .heavy:
            return .init(name: "Tajawal-ExtraBold", size: pointSize)
        case .medium, .semibold:
            return .init(name: "Tajawal-Medium", size: pointSize)
        default:
            return .init(name: "Tajawal-Regular", size: pointSize)
        }
    }
}

extension UIFont {
    
    var weight:  UIFont.Weight {
        let fontAttributeKey = UIFontDescriptor.AttributeName.init(rawValue: "NSCTFontUIUsageAttribute")
        guard let fontWeight = self.fontDescriptor.fontAttributes[fontAttributeKey] as? String else {
            return UIFont.Weight.regular
        }
        
        switch fontWeight {
        case "CTFontBoldUsage":
            return UIFont.Weight.bold
            
        case "CTFontBlackUsage":
            return UIFont.Weight.black
            
        case "CTFontHeavyUsage":
            return UIFont.Weight.heavy
            
        case "CTFontUltraLightUsage":
            return UIFont.Weight.ultraLight
            
        case "CTFontThinUsage":
            return UIFont.Weight.thin
            
        case "CTFontLightUsage":
            return UIFont.Weight.light
            
        case "CTFontMediumUsage":
            return UIFont.Weight.medium
            
        case "CTFontDemiUsage":
            return UIFont.Weight.semibold
            
        case "CTFontRegularUsage":
            return UIFont.Weight.regular
            
        default:
            return UIFont.Weight.regular
        }
    }
}
