//
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        set {
            layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable public var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    @IBInspectable var shadow: UIColor? {
        set {
            guard let color = newValue else { return removeShadow() }
            let shadowLayer = ShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.frame, cornerRadius: layer.cornerRadius).cgPath
            shadowLayer.fillColor = UIColor.clear.cgColor
            shadowLayer.shadowColor = color.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 5
            shadowLayer.view = self
            shadowLayer.cornerRadius = layer.cornerRadius
            clipsToBounds = true

            if let view = superview {
                view.layer.insertSublayer(shadowLayer, at: 0)
            }
        } get {
            return UIColor.clear
        }
    }
    
    private func removeShadow() {
        guard let view = superview,
              let layers = view.layer.sublayers?.filter({ $0 is ShapeLayer }) as? [ShapeLayer],
              let shadow = layers.first(where: {$0.view == self})
        else { return }
        shadow.removeFromSuperlayer()
    }
    
    func setShadowWith(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float)  {
        let shadowLayer = ShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.frame, cornerRadius: layer.cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius
        shadowLayer.view = self
        shadowLayer.cornerRadius = layer.cornerRadius
        clipsToBounds = true
        
        if let view = superview {
            view.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
}

extension UIButton {
    var text: String? {
        if underlined {
            return titleLabel?.attributedText?.string
        }
        return titleLabel?.text
    }
    
    @IBInspectable public var underlined: Bool {
        set {
            let attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor : titleLabel?.textColor! as Any]
            let attStr = NSAttributedString.init(string: (titleLabel?.text?.localized)!, attributes: attrs)
            setTitleColor(titleLabel?.textColor!, for: .normal)
            setAttributedTitle(attStr, for: .normal)
        }
        get {
            return (titleLabel?.attributedText != nil)
        }
    }
}

class ShapeLayer: CAShapeLayer {
    weak var view: UIView?
    var color: UIColor = .clear
    
    convenience init(color: UIColor, frame: CGRect, cornerRadius: CGFloat) {
        self.init()
        self.color = color
        path = UIBezierPath(roundedRect: self.frame, cornerRadius: cornerRadius).cgPath
        fillColor = UIColor.clear.cgColor
        shadowColor = color.cgColor
        shadowPath = path
        shadowOffset = CGSize(width: 0, height: 0)
        shadowOpacity = 0.8
        shadowRadius = 5
        self.cornerRadius = cornerRadius
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            debugPrint("error:", error)
            return nil
        }
    }
    
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension String {
    var html2AttributedString: NSAttributedString? { Data(utf8).html2AttributedString }
    
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension UIPageControl {
    func customPageControl(dotFillColor:UIColor, dotBorderColor:UIColor, dotBorderWidth:CGFloat) {
        for (pageIndex, dotView) in self.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotFillColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            } else {
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }

}
