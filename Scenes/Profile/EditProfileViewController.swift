//
//  EditProfileViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 24/05/2022.
//

import UIKit

class EditProfileViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    // MARK: - Variables
    override var topViewHeight: Int {
        return 100
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "edit_personal_info".localized
        guard let user = UserModel.current else { return }
        fullNameTF.text = user.name
        emailTF.text = user.email
    }
    
    // MARK: - Actions
    @IBAction func saveClicked(_ sender: UIButton) {
        if fullNameTF.isEmpty {
            Alert.show(message: "invalidName")
            return
        }
        if emailTF.isEmpty {
            Alert.show(message: "Please_enter_valid_email")
            return
        }
        Hud.show()
        APIs.updateUserInfo(name: fullNameTF.text!, email: emailTF.text!).done {
            $0.store()
            Alert.show(title: nil, message: "success_update", cancelTitle: "ok", otherTitles: []) {[weak self] _ in
                self?.pop()
            }
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
    
}
