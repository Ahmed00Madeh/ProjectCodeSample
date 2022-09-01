//
//  SplashViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 02/06/2022.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let controller = SelectCountryViewController()
        controller.delegate = self
        present(controller, animated: true)
    }
}

extension SplashViewController: SelectCountryViewControllerDelegate {
    /// Save Country then restart the app
    func selectCountryViewController(_ controller: SelectCountryViewController, didSelect country: CountryModel) {
        country.store()
        UIApplication.initWindow()
    }
    
    /// Do nothing in cancelation
    func selectCountryViewController(_ controller: SelectCountryViewController, didCancel: Bool) { }
}
