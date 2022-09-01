//
//  UICollectionViewExtensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(ofType type: T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indxPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: T.identifier, for: indxPath) as? T
    }
}

extension UICollectionViewCell {
    static var identifier: String { String(describing: self) }
    
    static var nib: UINib { UINib.init(nibName: identifier, bundle: .main) }
}
