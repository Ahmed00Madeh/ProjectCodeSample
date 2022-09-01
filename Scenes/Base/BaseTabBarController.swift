//
//  BaseTabBarController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class BaseTabBarController: UITabBarController {

    // MARK: - Life Cycle
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [HomeViewController(),
                                CategoriesViewController(),
                                OffersViewController()]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTabBar()
    }
    
    // MARK: - Functions
    private func styleTabBar() {
        let font = UIFont.appFont(ofSize: 12, weight: .regular)!
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                         for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .selected)
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(named: "DarkOrange")
        tabBar.unselectedItemTintColor = .black
    }
}

