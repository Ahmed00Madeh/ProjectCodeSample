//
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UIApplication {
    static func initWindow() {
        (UIApplication.shared.delegate as! AppDelegate).initWindow()
    }
    
    static func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    static func call(mobile: String) {
        guard let url = URL(string: "tel://\(mobile)") else {
            return Alert.show(message: "Invalid mobile number \(mobile)")
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

