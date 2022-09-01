//
//  NavigationActionsView.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 02/06/2022.
//

import UIKit

class NavigationActionsView: ReusableView {

    // MARK: - Outlets
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
