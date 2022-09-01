//
//  RateSupplierViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 16/06/2022.
//

import UIKit
import Cosmos

class RateSupplierViewController: PresentingViewController {

    // MARK: - Outlets
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var commentTV: UITextView!
    
    // MARK: - Variables
    let offerId: Int
    
    // MARK: - Life Cycle
    init(offerId: Int) {
        self.offerId = offerId
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        rateView.didFinishTouchingCosmos = { [weak self] in
            switch $0 {
            case 1:
                self?.rateLabel.text = "Very Bad"
            case 2:
                self?.rateLabel.text = "Not good"
            case 3:
                self?.rateLabel.text = "Quite ok"
            case 4:
                self?.rateLabel.text = "Very Good"
            case 5:
                self?.rateLabel.text = "Excellent !!!"
            default:
                break
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func sendClicked(_ sender: UIButton) {
        if rateView.rating == 0.0 {
            return Alert.show(message: "Please choose a rate")
        }
        if commentTV.text!.isEmpty {
            return Alert.show(message: "Please enter a comment")
        }
        
        Hud.show()
        APIs.rateOffer(
            rate: rateView.rating,
            comment: commentTV.text!,
            offerId: offerId
        ).done { [weak self] _ in
            Alert.show(
                title: nil,
                message: "Rated Successfully",
                cancelTitle: "Ok",
                otherTitles: []
            ) { _ in
                self?.dismiss(animated: true)
            }
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
}
