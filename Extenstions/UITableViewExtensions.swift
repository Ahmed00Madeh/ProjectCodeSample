//
//  UITableViewExtensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

/// Used to register genric cell as long as its a table view cell
extension UITableView {
    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T? {
        dequeueReusableCell(withIdentifier: T.identifier) as? T
    }
}
extension UITableViewCell {
    static var identifier: String { String(describing: self) }
    
    static var nib: UINib { UINib.init(nibName: identifier, bundle: .main) }
}
