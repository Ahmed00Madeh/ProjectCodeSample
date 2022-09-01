//
//  BaseViewController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchViewTop: NSLayoutConstraint!

    // MARK: - Variables
    var topViewHeight: Int { 160 }
    
    lazy var topView: UIView = {
        let _view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 100))
        _view.backgroundColor = UIColor(displayP3Red: 240/255, green: 86/255, blue: 24/255, alpha: 1)
        return _view
    }()
    
    // MARK: - LifeCycle
    init() { super.init(nibName: nil, bundle: nil) }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
            
    deinit { debugPrint(String(describing: type(of: self)) + "  Deinit") }
    
    // MARK: - Functions
    func setupView() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let color = UIColor.black
        navigationController?.navigationBar.tintColor = color
        let font = UIFont.appFont(ofSize: 20, weight: .bold) ?? UIFont.boldSystemFont(ofSize: 20)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color, .font: font]
        if shouldShowTopView() { setupTopView() }

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .init(named: shouldShowTopView() ? "white-arrow" : "black-arrow")?.imageFlippedForRightToLeftLayoutDirection(), style: .plain, target: self, action: #selector(customBackClicked))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = !shouldShowNavigation()
    }
    
    func shouldShowDismissButon() -> Bool { false }
    
    func shouldShowNavigation() -> Bool { true }
    
    func shouldShowTopView() -> Bool { true }
    
    func setupTopView() {
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(self.topViewHeight)
        }
        view.sendSubviewToBack(topView)
        guard searchViewTop != nil else { return }
        searchViewTop.constant = CGFloat(topViewHeight - 20)
    }
    
    @objc
    func customBackClicked() { pop() }

    // MARK: - Actions
}
