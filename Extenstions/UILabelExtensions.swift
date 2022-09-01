//
//  CollectionViewCell.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UILabel {
    var contentSize: CGSize { (text?.size(usingFont: font))! }
    
    func addBulletLabel(icon : String = "●" ,color: UIColor) {
        let  DelevieryDateString = icon + " " + text!
        let DelevieryDateStr: NSMutableAttributedString =  NSMutableAttributedString(string: DelevieryDateString)
        DelevieryDateStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location:0, length: 1))
        attributedText = DelevieryDateStr
    }
}
