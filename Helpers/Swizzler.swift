//
//  Swizzler.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

final class Swizzler {
    static func swizzleForlocalize() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        MethodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.awakeFromNib), overrideSelector: #selector(UITextField.cstmAwakeFromNib))
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.awakeFromNib), overrideSelector: #selector(UILabel.cstmAwakeFromNib))
        MethodSwizzleGivenClassName(cls: UITextView.self, originalSelector: #selector(UITextView.awakeFromNib), overrideSelector: #selector(UITextView.cstmAwakeFromNib))
        MethodSwizzleGivenClassName(cls: UIButton.self, originalSelector: #selector(UIButton.awakeFromNib), overrideSelector: #selector(UIButton.cstmAwakeFromNib))
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(setter: UILabel.text), overrideSelector:#selector(UILabel.customSetText(text:)))
    }
    static func swizzleForUI() {
        MethodSwizzleGivenClassName(cls: UIView.self, originalSelector: #selector(UIView.layoutSubviews), overrideSelector: #selector(UIView.cstmlayoutSubviews))
    }
}
extension UIView {
    @objc func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        guard let layers = self.layer.sublayers  else { return }
        
        for layer in layers {
            if let layer = layer as? ShapeLayer{
                if let view = subviews.first(where: { $0 == layer.view }) {
                    // update shadow
                    layer.path = UIBezierPath(roundedRect: view.frame, cornerRadius: view.cornerRadius).cgPath
                    layer.shadowPath = layer.path
//                    layer.shadowColor = layer.color.cgColor
                }
            } else if layer is CAGradientLayer {
                layer.frame = bounds
            }
        }
    }
}
extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            let currentLanguage = Language.currentLanguage.rawValue
            var bundle = Bundle();
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } else {
                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
    var localizedMain : Bundle {
        get {
            if let path = Bundle.main.path(forResource: Language.currentLanguage.rawValue, ofType: "lproj") {
                if let bundle = Bundle.init(path: path) {
                    return bundle
                } else {
                    return Bundle.main
                }
            } else {
                return Bundle.main
            }
        }
    }
}

extension UILabel {
    
    @objc public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()

        self.text = self.text?.localized
        self.font = self.font.appFont()
        self.adjustsFontSizeToFitWidth = false
        if self.textAlignment == .center { return }
        if Language.isArabic {
            if self.textAlignment == .right { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .left { return }
            self.textAlignment = .left
        }
    }
    
    @objc func customSetText(text: String) {
        self.customSetText(text: text.localized)
    }
}

extension UITextField {
    @objc public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()

        self.text = self.text?.localized
        self.font = self.font?.appFont()
        if self.textAlignment == .center { return }
        if Language.isArabic  {
            if self.textAlignment == .right { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .left { return }
            self.textAlignment = .left
        }
    }
}

extension UITextView {
    @objc public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()

        self.text = self.text?.localized
        self.font = self.font?.appFont()
        if self.textAlignment == .center { return }
        if Language.isArabic  {
            if self.textAlignment == .right { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .left { return }
            self.textAlignment = .left
        }
    }
}

extension UIButton {
    @objc public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()
        
        if let label = titleLabel, let text =  label.text {
            label.font = label.font.appFont()
            setTitle(text.localized, for: .normal)
        }
        if self.contentHorizontalAlignment == .center { return }
        if self.contentHorizontalAlignment == .right && Language.isArabic {
            self.contentHorizontalAlignment = .left
            return
        }
        if self.contentHorizontalAlignment == .left && Language.isArabic {
            self.contentHorizontalAlignment = .right
            return
        }
    }
}
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
