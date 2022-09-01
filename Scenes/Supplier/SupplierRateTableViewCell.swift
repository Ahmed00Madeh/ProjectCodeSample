//
//  SupplierRateTableViewCell.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 13/06/2022.
//

import UIKit
import Cosmos

class SupplierRateTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var comment: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
