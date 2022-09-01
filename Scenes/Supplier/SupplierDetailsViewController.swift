//
//  SupplierDetailsViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 16/06/2022.
//

import UIKit

class SupplierDetailsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    let provider: ProviderModel
    var model = PagedObject<OfferModel>()
    
    // MARK: - Life Cycle
    init(provider: ProviderModel) {
        self.provider = provider
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
        title = provider.name
        supplierName.text = provider.name
        desc.text = provider.desc
        collectionView.registerCell(ofType: HomeSliderCollectionCell.self)
        tableView.registerCell(ofType: OfferTableViewCell.self)
        pageControl.numberOfPages = provider.coverImages.count
        loadOffers()
    }
    
    func loadOffers() {
        Hud.show()
        APIs.getProviderOffers(providerId: provider.id, page: model.nextPage).done { [weak self] in
            guard let self = self else { return }
            self.model.append($0)
            self.tableViewHeight.constant = CGFloat(self.model.items.count * 140)
            self.tableView.reloadData()
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
    
    // MARK: - Actions
    @IBAction func callNowClicked(_ sender: UIButton) {
        var phones = [String]()
        if !provider.phone.isEmpty {
            phones.append(provider.phone)
        }
        if !provider.phone2.isEmpty {
            phones.append(provider.phone2)
        }
        ActionSheet.show(title: "Call Phone", cancelTitle: "Cancel", otherTitles: phones, sender: sender) { index in
            if index != 0 {
                UIApplication.call(mobile: phones[index - 1])
            }
        }
    }
    
    @IBAction func openMapClicked(_ sender: UIButton) {
        MapUtil.visit(lat: provider.location.lat, long: provider.location.long)
    }
}

extension SupplierDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { provider.coverImages.count }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { collectionView.bounds.size }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeSliderCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        cell.sliderImageView.setImageWith(stringUrl: provider.coverImages[indexPath.row])
        return cell
    }
}

extension SupplierDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { model.items.count }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 140 }

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
