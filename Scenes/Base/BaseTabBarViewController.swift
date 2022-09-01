//
//  BaseTabBarViewController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
import SnapKit

class BaseTabBarViewController: BaseViewController {

    // MARK: - Life Cycle
    override init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = tabBarItemTitle()?.localized
        tabBarItem.image = tabBarItemImage()
        tabBarItem.selectedImage = tabBarItemSelectedImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.title = title
        setupNavigationItems()
    }
    
    // MARK: - Functions
    func tabBarItemTitle() -> String? { nil }
    
    func tabBarItemImage() -> UIImage? { nil }
    
    func tabBarItemSelectedImage() -> UIImage? { nil }
    
    override func setupView() {
        super.setupView()
        setupAppLogo()
    }
    
    private func setupAppLogo() {
        let imageView = UIImageView(
            image: .init(
                named: Language.isArabic ? "app_bar_imag Arabic" : "app_bar_imag"
            )
        )
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.leading.equalTo(20)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
        view.bringSubviewToFront(imageView)
    }
    
    private func setupNavigationItems() {
        let _view = NavigationActionsView(frame: CGRect(x: 0, y: 0, width: 136, height: 32))
        if let user = UserModel.current {
            _view.profileImageView.setImageWith(stringUrl: user.avatar, placeholder: .init(named: "user"))
        } else {
            _view.profileImageView.image = .init(named: "user")
        }
        _view.profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        _view.languageButton.addTarget(self, action: #selector(changeLangauge), for: .touchUpInside)
        _view.notificationsButton.addTarget(self, action: #selector(openNotifications), for: .touchUpInside)
        view.addSubview(_view)
        
        _view.snp.makeConstraints { make in
            make.top.equalTo(90)
            make.trailing.equalTo(self.view.snp.trailing).inset(20)
            make.height.equalTo(32)
        }
        view.bringSubviewToFront(_view)
    }
    
    @objc
    private func changeLangauge() {
        Alert.show(
            title: "change_language",
            message: "are_you_sure_you_want_to_change_app_language",
            cancelTitle: "Back",
            otherTitles: ["Yes"]
        ) { index in
            guard index == 1 else { return }
            Language.switchLange()
            UIApplication.initWindow()
        }
    }
    
    @objc
    private func openNotifications() {
        push(controller: NotificationsViewController())
    }
    
    @objc
    private func openProfile() {
        push(controller: UserModel.current != nil ? ProfileViewController() : LoginViewController())
    }
}
