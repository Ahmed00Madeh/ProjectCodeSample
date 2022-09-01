//
//  CategoryTableViewCell.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 31/05/2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    // MARK: - Variables
    var category: CategoryModel! {
        didSet {
            categoryImageView.setImageWith(stringUrl: category.image)
            categoryName.text = category.name
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
