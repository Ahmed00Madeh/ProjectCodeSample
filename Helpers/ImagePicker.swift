//
//  ImagePicker.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class ImagePicker: NSObject {
    static let shared = ImagePicker()
    var comletion : (( _ image: UIImage?) -> Void)!
    
    static func pickImage(sender: UIView, completion: @escaping (_ image: UIImage?) -> Void) {
        ImagePicker.shared.comletion = completion
        ActionSheet.show(title: "Pick Your Picture", cancelTitle: "cancel",
                         otherTitles: ["Choose from Library", "Take a Picture from Camera"],
                         sender: sender) { index in
            if index == 0 { return }
            self.pickImage(sourceType: index == 1 ? .photoLibrary : .camera)
        }
    }
    
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage]
        ImagePicker.shared.comletion(image as? UIImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        ImagePicker.shared.comletion(nil)
        picker.dismiss(animated: true, completion: nil)
    }
    static func pickImage(sourceType : UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = ImagePicker.shared
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        UIApplication.topViewController()?.present(imagePicker, animated: true, completion: nil)
    }
    
}
