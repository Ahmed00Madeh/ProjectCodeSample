//
//  UINavigationControllerExtensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
extension UINavigationController {
    
    func popViewController(backIndex: Int, animated: Bool = true)  {
        let index = viewControllers.count - backIndex - 1
        popToViewController(viewControllers[index], animated: animated)
    }
    
    func popToViewController(identifier: String, animated: Bool = true)  {
        for controller in viewControllers {
            if identifier == controller.restorationIdentifier {
                popToViewController(controller, animated: animated)
                return
            }
        }
    }

    func containsController(identifier : String) -> Bool {
        for controller in viewControllers {
            if identifier == controller.restorationIdentifier {
                return true
            }
        }
        return false
    }
    
    func controller(identifier : String) -> UIViewController? {
        for controller in viewControllers {
            if identifier == controller.restorationIdentifier {
                return controller
            }
        }
        return nil
    }
    
    func popToViewController(ofType : UIViewController.Type , animated : Bool = true)  {
        for controller in viewControllers {
            if ofType == type(of: controller) {
                popToViewController(controller, animated: animated)
                return
            }
        }
    }
    
    func containsController(ofType : UIViewController.Type) -> Bool {
        for controller in viewControllers {
            if ofType == type(of: controller) {
                return true
            }
        }
        return false
    }
    
    func controller(ofType : UIViewController.Type) -> UIViewController? {
        for controller in viewControllers {
            if ofType == type(of: controller) {
                return controller
            }
        }
        return nil
    }
}
