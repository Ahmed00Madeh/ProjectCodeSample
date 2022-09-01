//
//  UIImageViewExtension.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
import SDWebImage
import SnapKit
import MapKit

extension UIImageView {
    
    func maskWith(color: UIColor) {
        guard let tempImage = image?.withRenderingMode(.alwaysTemplate) else { return }
        image = tempImage
        tintColor = color
    }
    
    func setImageWith(stringUrl: String, placeholder: UIImage? = nil) {
        let finalPath = stringUrl.contains("http") ? stringUrl : (Constants.baseUrl + "/" + stringUrl.replacingOccurrences(of: "\\\\", with: "/"))
        let urlStr = (finalPath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url =  URL(string: urlStr!) else {
            debugPrint("invalid url --> " + urlStr!)
            return
        }
        sd_imageIndicator = SDWebImageActivityIndicator.gray
        sd_setImage(with: url, placeholderImage: placeholder, options: .delayPlaceholder)
    }
    
    func setImageWith(baseData: String, stringName: String? = "") {
        guard let imageData = Data(base64Encoded: baseData), !imageData.isEmpty else {
            return setImage(string: stringName)
        }
        
        image = UIImage(data: imageData)
    }
    
    /// Used to set an image to user profile from his first initials
    open func setImage(string: String?, color: UIColor? = nil, circular: Bool = true, textAttributes: [NSAttributedString.Key: Any]? = nil) {
        
        let _image = imageSnap(text: string != nil ? string?.initials : "", color: color ?? UIColor.white, circular: circular,  textAttributes: textAttributes ?? [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        if let newImage = _image {
            image = newImage
        }
    }
    
    private func imageSnap(text: String?, color: UIColor, circular: Bool, textAttributes: [NSAttributedString.Key: Any]?) -> UIImage? {
        
        let scale = Float(UIScreen.main.scale)
        var size = bounds.size
        if contentMode == .scaleToFill ||
            contentMode == .scaleAspectFill ||
            contentMode == .scaleAspectFit ||
            contentMode == .redraw {
            size.width = CGFloat(floorf((Float(size.width) * scale) / scale))
            size.height = CGFloat(floorf((Float(size.height) * scale) / scale))
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
        let context = UIGraphicsGetCurrentContext()
        if circular {
            let path = CGPath(ellipseIn: bounds, transform: nil)
            context?.addPath(path)
            context?.clip()
        }
        
        // Fill
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // Text
        if let text = text {
            let attributes = textAttributes ?? [(NSAttributedString.Key.foregroundColor as NSString) as NSAttributedString.Key: UIColor.white, (NSAttributedString.Key.font as NSString) as NSAttributedString.Key: UIFont.systemFont(ofSize: 15.0)]
            
            let textSize = text.size(usingFont: UIFont.systemFont(ofSize: 15.0))
            let bounds = self.bounds
            let rect = CGRect(x: bounds.size.width/2 - textSize.width/2 + 2, y: bounds.size.height/2 + 2 - textSize.height/2, width: textSize.width, height: textSize.height)
            
            text.draw(in: rect, withAttributes: attributes)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setRoundedImage() {
        layer.cornerRadius = (frame.width / 2)
        clipsToBounds = true
        layer.masksToBounds = true
    }
    
    @IBInspectable public var isArabicFlip: Bool {
        set {
            if Language.isArabic {
                flipHorizontal()
            }
        }
        get {
            return false
        }
    }

    @IBInspectable public var isEnglishFlip: Bool {
        set {
            if !Language.isArabic {
                flipHorizontal()
            }
        }
        get {
            return false
        }
    }
}
