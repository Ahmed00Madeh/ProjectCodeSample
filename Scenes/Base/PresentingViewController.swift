//
//  PresentingViewController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class PresentingViewController: UIViewController {
    
    // MARK: - LifeCycle
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        view.subviews.first?.cornerRadius = 27
        view.subviews.first?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let button = UIButton()
        view.addSubIntrinsicView(button)
        view.sendSubviewToBack(button)
        button.addTarget(self, action: #selector(dismissClicked(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @IBAction func dismissClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
extension PresentingViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentingController.init(presentedViewController: presented, presenting: presenting)
    }
}

private class PresentingController: UIPresentationController {
    
    fileprivate lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black.withAlphaComponent(0.44)
        button.alpha = 0.0
        button.addTarget(self, action: #selector(dismissButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        presentedViewController.view.cornerRadius = 27
        presentedViewController.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.addSubview(dismissButton)
        dismissButton.frame = containerView.bounds
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] contenxt in
            self?.dismissButton.alpha = 1.0
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] contenxt in
            self?.dismissButton.alpha = 0
        }, completion: nil)
    }
    
    @objc func dismissButtonClicked(_ sender: UIButton) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
