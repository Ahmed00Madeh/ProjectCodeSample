//
//  HomeProviderTableCell.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 28/05/2022.
//

import UIKit

class HomeProviderTableCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var providerImageView: UIImageView!
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var offersCount: UILabel!
    
    // MARK: - Variables
    var provider: ProviderModel! {
        didSet {
            providerImageView.setImageWith(stringUrl: provider.logo)
            providerName.text = provider.name
            addressLabel.text = provider.location.name
            offersCount.text = provider.offersCount.string() + " offers".localized
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
