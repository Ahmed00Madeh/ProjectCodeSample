//
//  RegisterViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 24/05/2022.
//

import UIKit

class RegisterViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var fullNameTF: UITextField!
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .init(
                named: "black-arrow"
            )?.imageFlippedForRightToLeftLayoutDirection(),
            style: .plain,
            target: self,
            action: #selector(customBackClicked)
        )
    }
    
    override func shouldShowTopView() -> Bool { false }
    
    // MARK: - Actions
    @IBAction func registerClicked(_ sender: UIButton) {
        if fullNameTF.isEmpty {
            return Alert.show(message: "invalidName")
        }
        if emailTF.isEmpty {
            return Alert.show(message: "Please_enter_valid_email")
        }
        if passwordTF.isEmpty || !passwordTF.text!.isValidPassword {
            return Alert.show(message: "type_password")
        }
        
        Hud.show()
        APIs.register(name: fullNameTF.text!, email: emailTF.text!, password: passwordTF.text!).done {
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
    
    @IBAction func loginClicked(_ sender: UIButton) { pop() }
}
