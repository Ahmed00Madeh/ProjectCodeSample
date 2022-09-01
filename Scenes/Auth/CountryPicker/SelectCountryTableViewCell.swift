//
//  SelectCountryTableViewCell.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 02/06/2022.
//

import UIKit

class SelectCountryTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var countryLogo: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
