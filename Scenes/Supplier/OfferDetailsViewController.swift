//
//  OfferDetailsViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 15/06/2022.
//

import UIKit
import Cosmos
import MapKit
import WEImageViewer

class OfferDetailsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var ratesNo: UILabel!
    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var snapChatButton: UIButton!
    @IBOutlet weak var tiktokButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var navigateButton: UIButton!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var descTV: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Variables
    let offer: OfferModel
    override var topViewHeight: Int { 110 }
    
    // MARK: - Life Cycle
    init(offer: OfferModel) {
        self.offer = offer
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
        title = "Offer Details".localized
        
        let shareButton = UIBarButtonItem(
            image: .init(named: "share-1"),
            style: .plain,
            target: self,
            action: #selector(shareClicked)
        )
        let rateButton = UIBarButtonItem(
            image: .init(named: "star"),
            style: .plain, target: self,
            action: #selector(rateClicked)
        )
        navigationItem.rightBarButtonItems = [rateButton, shareButton]
        
        collectionView.registerCell(ofType: HomeSliderCollectionCell.self)
        pageControl.numberOfPages = offer.images.count
        providerName.text = offer.provider.name
        
        if offer.rates.isEmpty {
            rateView.rating = 0.0
        } else {
            rateView.rating = Double((offer.rates.map { $0.rate }.reduce(0, +))
                                     / offer.rates.count)
        }
        
        ratesNo.text = offer.rates.count.string() + " Ratings".localized
        offerTitle.text = offer.name
        callButton.isHidden = offer.provider.phone.isEmpty && offer.provider.phone2.isEmpty
        fbButton.isHidden = offer.provider.facebook.isEmpty
        instagramButton.isHidden = offer.provider.instagram.isEmpty
        snapChatButton.isHidden = offer.provider.snapchat.isEmpty
        tiktokButton.isHidden = offer.provider.tiktok.isEmpty
        youtubeButton.isHidden = offer.provider.youtube.isEmpty
        descTV.text = offer.desc
        mapView.zoomToLocation(location: CLLocation(latitude: offer.provider.location.lat, longitude: offer.provider.location.long))
        mapView.addAnnotation(lat: offer.provider.location.lat,
                              long: offer.provider.location.long, title: "")
    }
    
    @objc
    func shareClicked() {
        let activityViewController = UIActivityViewController(activityItems: [offer.name, offer.desc], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    @objc
    func rateClicked() {
        if UserModel.current == nil {
            push(controller: LoginViewController())
        } else {
            present(RateSupplierViewController(offerId: offer.id), animated: true)
        }
    }
    
    // MARK: - Actions
    @IBAction func callClicked(_ sender: UIButton) {
        var phones = [String]()
        if !offer.provider.phone.isEmpty {
            phones.append(offer.provider.phone)
        }
        if !offer.provider.phone2.isEmpty {
            phones.append(offer.provider.phone2)
        }
        ActionSheet.show(title: "Call Phone", cancelTitle: "Cancel", otherTitles: phones, sender: sender) { index in
            if index != 0 {
                UIApplication.call(mobile: phones[index - 1])
            }
        }
    }
    
    @IBAction func fbClicked(_ sender: UIButton) {
        if let url = URL(string: offer.provider.facebook),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func instagramClicked(_ sender: UIButton) {
        if let url = URL(string: offer.provider.instagram),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @IBAction func snapChatClicked(_ sender: UIButton) {
        if let url = URL(string: offer.provider.snapchat),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @IBAction func tiktokClicked(_ sender: UIButton) {
        if let url = URL(string: offer.provider.tiktok),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @IBAction func youtubeClicked(_ sender: UIButton) {
        if let url = URL(string: offer.provider.youtube),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @IBAction func navigateClicked(_ sender: UIButton) {
        MapUtil.visit(lat: offer.provider.location.lat,
                      long: offer.provider.location.long)
    }
    
    @IBAction func ratesClicked(_ sender: UIButton) {
        push(controller: SupplierRatesViewController(rates: offer.rates))
    }
}

extension OfferDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { offer.images.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeSliderCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        cell.sliderImageView.setImageWith(stringUrl: offer.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { collectionView.bounds.size }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? HomeSliderCollectionCell {
                let imageBrowser = WEImageViewController()
                imageBrowser.show(self.navigationController, senderView: cell.sliderImageView)
        }
    }
}
