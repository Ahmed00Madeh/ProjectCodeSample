//
//  SelectCountryViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 02/06/2022.
//

import UIKit

protocol SelectCountryViewControllerDelegate: AnyObject {
    func selectCountryViewController(_ controller: SelectCountryViewController, didSelect country: CountryModel)
    func selectCountryViewController(_ controller: SelectCountryViewController, didCancel: Bool)
}

class SelectCountryViewController: PresentingViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    var countries: [CountryModel] = []
    weak var delegate: SelectCountryViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        tableView.registerCell(ofType: SelectCountryTableViewCell.self)
        loadCountries()
    }
    
    func loadCountries() {
        Hud.show()
        APIs.listCountries().done { [weak self] countries in
            guard let self = self else { return }
            self.countries = countries
            self.tableHeight.constant = CGFloat(countries.count * 40)
            self.tableView.reloadData()
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
    
    // MARK: - Actions
    override func dismissClicked(_ sender: UIButton) {
        delegate?.selectCountryViewController(self, didCancel: true)
    }
}

extension SelectCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { countries.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 40 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SelectCountryTableViewCell = tableView.dequeueReusableCell()!
        cell.countryLogo.setImageWith(stringUrl: countries[indexPath.row].image)
        cell.countryName.text = countries[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectCountryViewController(self, didSelect: countries[indexPath.row])
    }
}
