//
//  NavigationController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class NavigationController: UINavigationController {

    // MARK: - Variables    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .white
        navigationBar.isTranslucent = true
        view.backgroundColor = .clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .white
        
        if Language.isArabic {
            view.semanticContentAttribute = .forceRightToLeft
            navigationBar.semanticContentAttribute = .forceRightToLeft
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes ([.foregroundColor: UIColor.clear], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes ([.foregroundColor: UIColor.clear], for: .normal)
        navigationBar.standardAppearance = appearance
    }
}
