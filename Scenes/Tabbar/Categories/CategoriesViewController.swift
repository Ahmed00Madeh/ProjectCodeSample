//
//  CategoriesViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 30/05/2022.
//

import UIKit

class CategoriesViewController: BaseTabBarViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var model = PagedObject<CategoryModel>()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        tableView.registerCell(ofType: CategoryTableViewCell.self)
        loadCategories()
    }
    
    override func tabBarItemTitle() -> String? { "nav_categories".localized }
    
    override func tabBarItemImage() -> UIImage? { .init(named: "menu") }
    
    override func tabBarItemSelectedImage() -> UIImage? { .init(named: "menu (1)") }
    
    func loadCategories() {
        Hud.show()
        APIs.listCategories(page: model.nextPage).done { [weak self] model in
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
        push(controller: SearchViewController(searchType: .suppliers))
    }
    
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { model.items.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 140 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryTableViewCell = tableView.dequeueReusableCell()!
        cell.category = model.items[indexPath.row]
        return cell
    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /// Used for pagination
        if model.hasNext(indexPath) {
            loadCategories()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(controller: CategoryProvidersViewController(category: model.items[indexPath.row]))
    }
}
