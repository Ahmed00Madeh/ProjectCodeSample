//
//  UIViewExtensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
import SnapKit

extension UIView {
    
    func setShadowwithGradientColors() {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [UIColor.red.cgColor,
                                UIColor.yellow.cgColor,
                                UIColor.green.cgColor,
                                UIColor.blue.cgColor]
        gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        
        gradientLayer.frame = CGRect.init(
            x: frame.minX - 40,
            y: frame.minY - 40,
            width: frame.width + 80,
            height: frame.height + 80)
        gradientLayer.masksToBounds = true
        
        let shadowLayer = CALayer.init()
        shadowLayer.frame = gradientLayer.bounds
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOpacity = 0.08
        shadowLayer.shadowRadius = 20
        shadowLayer.shadowPath = CGPath.init(rect: shadowLayer.bounds, transform: nil)
        
        gradientLayer.mask = shadowLayer
        superview?.layer.insertSublayer(gradientLayer, below: layer)
    }
    
    func screenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
       drawHierarchy(in: bounds, afterScreenUpdates: true)
       let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return newImage
    }

    func rotate(_ degrees: Double) {
        transform = CGAffineTransform(rotationAngle: CGFloat(degrees * Double.pi/180));
    }
    
    func addActivityindicator() {
        let indicator = UIActivityIndicatorView.init(style: .medium)
        addSubview(indicator)
        indicator.snp.makeConstraints { (maker) in
            maker.leading.equalTo(snp.leading)
            maker.trailing.equalTo(snp.trailing)
            maker.top.equalTo(snp.top)
            maker.bottom.equalTo(snp.bottom)
        }
    }
    
    func removeActivityindicator() {
        guard let view = subviews.first(where: {$0 is UIActivityIndicatorView}) else {
            return
        }
        view.removeFromSuperview()
    }
}

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func flipHorizontal() {
        transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    func flipVertical() {
        transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
    func setRounded()  {
        layer.cornerRadius = bounds.height / 2
    }
}

extension UIView {
    func addSubIntrinsicView(_ view: UIView, replace: Bool = false)  {
        if replace {
            subviews.forEach({$0.removeFromSuperview()})
        }
        addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    func updateRateTransform() {
        self.transform = Language.isArabic
            ? CGAffineTransform.init(scaleX: -1, y: 1)
            : .identity
    }

    func layerGradient(colors c:[CGColor])->CAGradientLayer {
            self.layer.sublayers = self.layer.sublayers?.filter(){!($0 is CAGradientLayer)}
            let layer : CAGradientLayer = CAGradientLayer()
            layer.frame.size = self.frame.size
            layer.colors = c
            self.layer.insertSublayer(layer, at: 0)
            return layer
    }
}

extension UIView {
    func recursiveSubviews() -> [UIView] {
        var recursiveSubviews = self.subviews
        subviews.forEach { recursiveSubviews.append(contentsOf: $0.recursiveSubviews()) }
        return recursiveSubviews
    }
}

@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }
}
