//
//  OffersViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 01/06/2022.
//

import UIKit

class OffersViewController: BaseTabBarViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var model = PagedObject<OfferModel>()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        tableView.registerCell(ofType: OfferTableViewCell.self)
        loadOffers()
    }
    
    override func tabBarItemTitle() -> String? { "nav_offers".localized }
    
    override func tabBarItemImage() -> UIImage? { .init(named: "offers") }
    
    func loadOffers() {
        Hud.show()
        APIs.listOffers(countryId: CountryModel.current?.id ?? 0, page: model.nextPage).done { [weak self] model in
            guard let self = self else { return }
            self.model.append(model)
            self.tableView.reloadData()
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
    
    // MARK: - Actions
    @IBAction func searchClicked(_ sender: UIButton) {
        push(controller: SearchViewController(searchType: .offers))
    }
}

extension OffersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { model.items.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 170 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OfferTableViewCell = tableView.dequeueReusableCell()!
        cell.offer = model.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(controller: OfferDetailsViewController(offer: model.items[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if model.hasNext(indexPath) {
            loadOffers()
        }
    }
}
