//
//  ActionSheet.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class ActionSheet: NSObject {
    
    class func show(title : String, message: String = "" , cancelTitle : String , otherTitles : [String], sender: UIView, completion :@escaping (_ index : Int) -> Void)  {
                
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
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
}
