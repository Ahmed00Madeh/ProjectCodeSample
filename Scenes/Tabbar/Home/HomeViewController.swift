//
//  HomeViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 27/05/2022.
//

import UIKit
import PromiseKit

let PROVIDER_CELL_HEIGHT = CGFloat(150)

class HomeViewController: BaseTabBarViewController {

    // MARK: - Outlets
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var providersView: UIView!
    @IBOutlet weak var providersTableView: UITableView!
    @IBOutlet weak var pageContol: UIPageControl!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    var sliders: [OfferModel] = [] {
        didSet {
            pageContol.numberOfPages = sliders.count
            pageContol.currentPage = 0
            sliderView.isHidden = sliders.isEmpty
            sliderCollectionView.reloadData()
        }
    }
    
    var categories: [CategoryModel] = [] {
        didSet {
            categoriesView.isHidden = categories.isEmpty
            categoriesCollectionView.reloadData()
        }
    }
    
    var providers: [ProviderModel] = [] {
        didSet {
            providersView.isHidden = providers.isEmpty
            tableViewHeight.constant = CGFloat(providers.count) * PROVIDER_CELL_HEIGHT
            providersTableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHome()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        sliderCollectionView.registerCell(ofType: HomeSliderCollectionCell.self)
        categoriesCollectionView.registerCell(ofType: HomeCategoryCollectionCell.self)
        providersTableView.registerCell(ofType: HomeProviderTableCell.self)
        categoriesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        sliderCollectionView.semanticContentAttribute = .forceLeftToRight
        categoriesCollectionView.semanticContentAttribute = .forceLeftToRight
        pageContol.semanticContentAttribute = .forceLeftToRight
        if Language.isArabic {
            pageContol.transform = CGAffineTransform(scaleX: -1, y: 1)
            sliderCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
            categoriesCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    override func tabBarItemTitle() -> String? { "nav_home".localized }
    
    override func tabBarItemImage() -> UIImage? { .init(named: "home-page (1)") }
    
    override func tabBarItemSelectedImage() -> UIImage? { .init(named: "home-page") }
    
    func loadHome() {
        Hud.show()
        when(fulfilled: APIs.listCategories(page: 0),
             APIs.listOffers(countryId: CountryModel.current?.id ?? 1, page: 0),
             APIs.listProviders(countryId: CountryModel.current?.id ?? 1, page: 0)
        ).done {[weak self] categoryModel, offerModel, providerModel in
            guard let self = self else { return }
            self.categories = categoryModel.items
            self.sliders = offerModel.items
            self.providers = providerModel.items
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == sliderCollectionView ? sliders.count : categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sliderCollectionView {
            return collectionView.bounds.size
        } else {
            return CGSize(width: 120, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollectionView {
            let cell: HomeSliderCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
            cell.sliderImageView.setImageWith(stringUrl: sliders[indexPath.row].images.first ?? "")
            if Language.isArabic {
                cell.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            return cell
        } else {
            let cell: HomeCategoryCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
            cell.categoryImageView.setImageWith(stringUrl: categories[indexPath.row].image)
            cell.categoryName.text = categories[indexPath.row].name
            if Language.isArabic {
                cell.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sliderCollectionView {
            push(controller: OfferDetailsViewController(offer: sliders[indexPath.row]))
        } else {
            push(controller: CategoryProvidersViewController(category: categories[indexPath.row]))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == sliderCollectionView {
            pageContol.currentPage = indexPath.row
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { providers.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { PROVIDER_CELL_HEIGHT }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeProviderTableCell = tableView.dequeueReusableCell()!
        cell.provider = providers[indexPath.row]
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(controller: SupplierDetailsViewController(provider: providers[indexPath.row]))
    }
}
