//
//  UIImageExtension.swift
//
//  Created by Ahmed Madeh.
//

import UIKit


extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func base64() -> String {
        guard let data = jpegData(compressionQuality: 0.4) else { return "" }
        return data.base64EncodedString()
    }
    
    func rezised(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        let newImage = self
        newImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext() ?? .init()
    }

    class func imageWithInitials(initials : String, size : CGSize) -> UIImage {
        let imageview = UIImageView.init(frame: CGRect.init(origin: .zero, size: size))
        imageview.setImage(string: initials, color: UIColor.red, circular: true, textAttributes: nil)
        return imageview.image ?? .init()
    }
    
    static var avatar: UIImage { UIImage.init(named: "user-avatar") ?? .init() }
}
