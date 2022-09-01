//
//  SupplierRatesViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 13/06/2022.
//

import UIKit

class SupplierRatesViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var rates: [RateModel] = []
    
    // MARK: - Life Cycle
    init(rates: [RateModel]) {
        self.rates = rates
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "rates".localized
        tableView.registerCell(ofType: SupplierRateTableViewCell.self)
    }
}

extension SupplierRatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { rates.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SupplierRateTableViewCell = tableView.dequeueReusableCell()!
        let rate = rates[indexPath.row]
        cell.rateView.rating = Double(rate.rate)
        cell.comment.text = rate.comment
        cell.username.text = rate.user.name
        cell.userImageView.setImageWith(stringUrl: rate.user.avatar)
        return cell
    }
}
