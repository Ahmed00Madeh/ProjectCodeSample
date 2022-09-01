//
//  NotificationTableViewCell.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 02/06/2022.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var notificationImageView: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationDesc: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
