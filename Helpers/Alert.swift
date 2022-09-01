//
//  Alert.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
typealias TFConfigurationHandler =  ((UITextField) -> Swift.Void)?

class Alert: NSObject {
    
    class func show(title : String?, message: String?, cancelTitle : String , otherTitles : [String], sender: UIView, completion :@escaping (_ index : Int) -> Void)  {
        
        let alertController = createAlertController(title: title, message: message)
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: { (action) in
            completion(0)
        })
        alertController.addAction(cancelAction)
        for string in otherTitles {
            let action = UIAlertAction.init(title: string, style: .default, handler: { (action) in
                completion(otherTitles.firstIndex(of: string)! + 1)
            })
            alertController.addAction(action)
        }
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
            popoverController.permittedArrowDirections = .any
        }
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
        
    class func show(title : String?, message: String?, cancelTitle : String , otherTitles : [String], completion :@escaping (_ index : Int) -> Void)  {

        let alertController = createAlertController(title: title, message: message)

        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: { (action) in
            completion(0)
        })

        alertController.addAction(cancelAction)
        for string in otherTitles {
            let action = UIAlertAction.init(title: string, style: .default, handler: { (action) in
                completion(otherTitles.firstIndex(of: string)! + 1)
            })
            alertController.addAction(action)
        }

        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = UIView()
            popoverController.sourceRect = CGRect(x: 400, y: 800, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    class func show(title: String? = nil, message: String?)  {
        Alert.show(title: title, message: message, cancelTitle: "Ok", otherTitles: []) { (index) in}
    }
    
    class func show(title : String ,cancelTitle : String = "Cancel", otherTitles : [String], fields: [TFConfigurationHandler],completion :@escaping (_ index : Int,_ textFields: [UITextField]) -> Void) {
        let alertController = createAlertController(title: nil, message: title)
        for config in fields{
            alertController.addTextField(configurationHandler: config)
        }
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: { (action) in
            completion(0,[])
        })
        alertController.addAction(cancelAction)
        for string in otherTitles {
            let action = UIAlertAction.init(title: string, style: .default, handler: { (action) in
                completion(otherTitles.firstIndex(of: string)! + 1, alertController.textFields!)
            })
            alertController.addAction(action)
        }
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate static func createAlertController(title: String?, message: String?) -> UIAlertController {
        let controller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        return controller
    }
}
