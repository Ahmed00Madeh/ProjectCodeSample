//
//  ProfileViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 24/05/2022.
//

import UIKit

class ProfileViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        if let user = UserModel.current {
            if let _ = URL(string: user.avatar) {
                userImageView.setImageWith(stringUrl: user.avatar)
            } else {
                userImageView.setImage(string: user.name,
                                       color: .init(red: 0.937, green: 0.337, blue: 0.094, alpha: 0.90))
            }
            fullNameLabel.text = user.name
            emailLabel.text = user.email
        }
        guard let country = CountryModel.current else { return }
        countryImage.setImageWith(stringUrl: country.image)
    }
    
    private func updateImage(image: UIImage) {
        Hud.show()
        APIs.updateUserImage(image: image).done {[weak self] avatar in
            self?.userImageView.image = image
            let user = UserModel.current
            user?.avatar = avatar
            user?.store()
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
    
    private func confirmDeleteAccount() {
        Hud.show()
        APIs.deleteAccount().done { _ in
            UserModel.current = nil
            UIApplication.initWindow()
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
    
    // MARK: - Actions
    @IBAction func backClicked(_ sender: UIButton) {
        pop()
    }
    
    @IBAction func editImageClicked(_ sender: UIButton) {
        ImagePicker.pickImage(sender: userImageView) { [weak self] image in
            guard let self = self,
                  let image = image
            else { return }
            self.updateImage(image: image)
        }
    }
    
    @IBAction func editProfileClicked(_ sender: UIButton) {
        push(controller: EditProfileViewController())
    }
    
    @IBAction func changeLanguageClicked(_ sender: UIButton) {
        Alert.show(title: "change_language", message: "are_you_sure_you_want_to_change_app_language", cancelTitle: "Back", otherTitles: ["Yes"]) { index in
            if index == 1 {
                Language.switchLange()
                UIApplication.initWindow()
            }
        }
    }
    
    @IBAction func selectCountryClicked(_ sender: UIButton) {
        let controller = SelectCountryViewController()
        controller.delegate = self
        present(controller, animated: true)
    }
    
    @IBAction func shareClicked(_ sender: UIButton) {
        if let urlStr = NSURL(string: "https://apps.apple.com/us/app/id1636319347?ls=1&mt=8") {
            var objectsToShare = [Language.isArabic ? "مرحبًا ، تحقق من تطبيق Awfarlak على:" : "Hey check out Awfarlak App at:"]
            objectsToShare.append(urlStr.absoluteString ?? "")
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = self.view
                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                }
            }

            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func contactUsClicked(_ sender: UIButton) {
        push(controller: ContactUsViewController())
    }
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        UserModel.current = nil
        UIApplication.initWindow()
    }
    
    @IBAction func deleteAccountClicked(_ sender: UIButton) {
        Alert.show(title: "delete_account", message: "data_loss_warning", cancelTitle: "Cancel", otherTitles: ["delete"], sender: sender) { [weak self] index in
            if index == 1 {
                self?.confirmDeleteAccount()
            }
        }
    }
}

extension ProfileViewController: SelectCountryViewControllerDelegate {
    
    func selectCountryViewController(_ controller: SelectCountryViewController, didSelect country: CountryModel) {
        country.store()
        countryImage.setImageWith(stringUrl: country.image)
        controller.dismiss(animated: true)
    }
    
    func selectCountryViewController(_ controller: SelectCountryViewController, didCancel: Bool) {
        controller.dismiss(animated: true)
    }
    
}
