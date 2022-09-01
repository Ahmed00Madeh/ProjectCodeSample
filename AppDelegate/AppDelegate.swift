//
//  AppDelegate.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 23/05/2022.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Register device for notifications and firebase
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerForRemoteNotification()
        
        /// Localize the app
        Swizzler.swizzleForUI()
        Swizzler.swizzleForlocalize()
        
        IQKeyboardManager.shared.enable = true
        
        window = UIWindow()
        initWindow()
        
        return true
    }
    
    func setupAppearance() {
        UIView.appearance().semanticContentAttribute = Language.isArabic ? .forceRightToLeft : .forceLeftToRight
        UIBarButtonItem.appearance().setTitleTextAttributes ([.foregroundColor: UIColor.clear], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes ([.foregroundColor: UIColor.clear], for: .normal)
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "white-arrow")?.imageFlippedForRightToLeftLayoutDirection()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "white-arrow")?.imageFlippedForRightToLeftLayoutDirection()
    }
    
    func initWindow() {
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return }
        if CountryModel.current == nil {
            window.rootViewController = SplashViewController()
        } else {
            window.rootViewController = NavigationController(rootViewController: BaseTabBarController())
        }
        setupAppearance()
        window.makeKeyAndVisible()
    }
    
    func registerForRemoteNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert, .badge]) { granted, error in
            if error == nil {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        let deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        debugPrint("deviceTokenString \(deviceTokenString)")
    }
    
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.subscribe(toTopic: "all")
    }
}
