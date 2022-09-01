//
//  SearchViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 13/06/2022.
//

import UIKit
import CoreLocation

class SearchViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var nearestSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let searchType: SearchType
    var providersModel = PagedObject<ProviderModel>()
    var offersModel = PagedObject<OfferModel>()
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    
    // MARK: - Life Cycle
    init(searchType: SearchType) {
        self.searchType = searchType
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
        title = searchType == .offers ? "offers search".localized : "suppliers search".localized
        tableView.registerCell(ofType: HomeProviderTableCell.self)
        tableView.registerCell(ofType: OfferTableViewCell.self)
        
        if searchType == .offers {
            searchOffers()
        } else {
            searchProviders()
        }
        
        /// Ask for location permission
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    func searchProviders() {
        Hud.show()
        APIs.searchProviders(
            page: providersModel.nextPage,
            keyword: searchTF.text!,
            lat: 0.0,
            long: 0.0
        ).done { [weak self] model in
            guard let self = self else { return }
            self.providersModel.append(model)
            self.tableView.reloadData()
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
    
    func searchOffers() {
        Hud.show()
        APIs.searchOffers(
            page: offersModel.nextPage,
            keyword: searchTF.text!,
            lat: nearestSwitch.isOn ? currentLocation?.latitude ?? 0.0 : 0.0,
            long: nearestSwitch.isOn ? currentLocation?.longitude ?? 0.0 : 0.0
        ).done { [weak self] model in
            guard let self = self else { return }
            self.offersModel.append(model)
            self.tableView.reloadData()
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
    
    // MARK: - Actions
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn && currentLocation == nil {
            locationManager?.requestAlwaysAuthorization()
            return
        }

        offersModel.items.removeAll()
        providersModel.items.removeAll()
        tableView.reloadData()

        if searchType == .offers {
            searchOffers()
        } else {
            searchProviders()
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.isEmpty {
            offersModel.items.removeAll()
            providersModel.items.removeAll()
            tableView.reloadData()
            
            if searchType == .offers {
                searchOffers()
            } else {
                searchProviders()
            }
        }
        view.endEditing(true)
        return true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchType == .offers ? offersModel.items.count : providersModel.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { PROVIDER_CELL_HEIGHT }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchType == .offers {
            let cell: OfferTableViewCell = tableView.dequeueReusableCell()!
            cell.offer = offersModel.items[indexPath.row]
            return cell
        } else {
            let cell: HomeProviderTableCell = tableView.dequeueReusableCell()!
            cell.provider = providersModel.items[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchType == .offers && offersModel.hasNext(indexPath) {
            searchOffers()
        } else if searchType == .suppliers && providersModel.hasNext(indexPath) {
            searchProviders()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchType == .offers {
            push(controller: OfferDetailsViewController(offer: offersModel.items[indexPath.row]))
        } else {
            push(controller: SupplierDetailsViewController(provider: providersModel.items[indexPath.row]))
        }
    }
}

/// Location Delegate handlers
extension SearchViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location.coordinate
            locationManager?.stopUpdatingLocation()
            if nearestSwitch.isOn {
                offersModel.items.removeAll()
                providersModel.items.removeAll()
                tableView.reloadData()

                if searchType == .offers {
                    searchOffers()
                } else {
                    searchProviders()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(#function, error)
    }
}
