//
//  ContactUsViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 24/05/2022.
//

import UIKit

class ContactUsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneNoTF: UITextField!
    @IBOutlet weak var contentTV: UITextView!
    
    // MARK: - Variables
    override var topViewHeight: Int { 100 }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "contact_us".localized
    }
    
    // MARK: - Actions
    @IBAction func sendClicked(_ sender: UIButton) {
        if fullNameTF.isEmpty {
            return Alert.show(message: "invalidName")
        }
        if emailTF.isEmpty {
            return Alert.show(message: "Please_enter_valid_email")
        }
        if !phoneNoTF.text!.isPhoneNumber {
            return Alert.show(message: "enter_phone_number")
        }
        if contentTV.text!.isEmpty {
            return Alert.show(message: "enter_message_content")
        }
        
        Hud.show()
        APIs.contactUs(
            name: fullNameTF.text!,
            email: emailTF.text!,
            phone: phoneNoTF.text!,
            message: contentTV.text!
        ).done { _ in
            Alert.show(
                title: nil,
                message: "message_sent",
                cancelTitle: "ok",
                otherTitles: []
            ) { [weak self] _ in
                self?.pop()
            }
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
}
