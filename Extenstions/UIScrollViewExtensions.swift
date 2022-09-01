//
//  UIScrollViewExtensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UIScrollView {
    
    var isRefreshControlEnabled: Bool{
        set {
            if newValue {
                registerRefreshControl()
            } else {
                refreshControl = nil
            }
        } get {
            return refreshControl != nil
        }
    }
    
    private func registerRefreshControl()  {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(self.didRefresh(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    @objc
    private func didRefresh(_ sender: UIRefreshControl)  {
        if let delegate = delegate as? UIRefreshControlDelegate{
            delegate.didRefresh(sender)
        }
    }
    
}

@objc
protocol UIRefreshControlDelegate: AnyObject {
    func didRefresh(_ refreshControl: UIRefreshControl)
}
