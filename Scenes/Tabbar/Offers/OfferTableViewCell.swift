//
//  OfferTableViewCell.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 02/06/2022.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerName: UILabel!
    @IBOutlet weak var vendorName: UILabel!
    
    // MARK: - Variables
    var offer: OfferModel! {
        didSet {
            offerImageView.setImageWith(stringUrl: offer.provider.logo)
            offerName.text = offer.name
            vendorName.text = offer.provider.name
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
