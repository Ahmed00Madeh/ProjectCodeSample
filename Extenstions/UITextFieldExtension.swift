//
//  UITextFieldExtension.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UITextField {
    var isEmpty: Bool {
        (text?.isEmpty)! || text! == String(repeating: " ", count: text!.count)
    }
    
    func setPlaceHolderColor(color : UIColor){
        attributedPlaceholder = NSAttributedString(string:(self.placeholder ?? "").localized, attributes: [NSAttributedString.Key.foregroundColor: color])
        
    }
}

extension UITextField {
    private func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    private func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
    
    @IBInspectable var leftPadding: CGFloat {
        set {
            setLeftPaddingPoints(newValue)
        } get {
            if let view = leftView {
                return view.frame.width
            }
            return 0
        }
    }
    
    @IBInspectable var rightPadding: CGFloat {
        set {
            setRightPaddingPoints(newValue)
        } get {
            if let view = rightView {
                return view.frame.width
            }
            return 0
        }
    }
}



