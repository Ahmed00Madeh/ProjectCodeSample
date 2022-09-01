//
//  LoginViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 24/05/2022.
//

import UIKit

class LoginViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
    }
    
    override func shouldShowTopView() -> Bool { false }
    
    // MARK: - Actions
    @IBAction func loginClicked(_ sender: UIButton) {
        if emailTF.isEmpty {
            return Alert.show(message: "Please_enter_valid_email")
        }
        if passwordTF.isEmpty || !passwordTF.text!.isValidPassword {
            return Alert.show(message: "type_password")
        }
        Hud.show()
        APIs.login(email: emailTF.text!, password: passwordTF.text!).done {
            $0.store()
            UIApplication.initWindow()
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
    
    @IBAction func termsOfUseClicked(_ sender: UIButton) {
        if let url = URL(string: Constants.termsUrl),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func privacyPolicyClicked(_ sender: UIButton) {
        if let url = URL(string: Constants.privacyUrl),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        push(controller: RegisterViewController())
    }
}
