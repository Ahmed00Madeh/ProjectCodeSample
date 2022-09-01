//
//  CategoryProvidersViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 02/06/2022.
//

import UIKit

class CategoryProvidersViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let category: CategoryModel
    var model = PagedObject<ProviderModel>()
    
    // MARK: - Life Cycle
    init(category: CategoryModel) {
        self.category = category
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
        title = category.name
        tableView.registerCell(ofType: HomeProviderTableCell.self)
        loadProviders()
    }
    
    func loadProviders() {
        Hud.show()
        APIs.getCategoryProviders(
            categoryId: category.id,
            page: model.nextPage
        ).done { [weak self] model in
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

}

extension CategoryProvidersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { model.items.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { PROVIDER_CELL_HEIGHT }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeProviderTableCell = tableView.dequeueReusableCell()!
        cell.provider = model.items[indexPath.row]
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(controller: SupplierDetailsViewController(provider: model.items[indexPath.row]))
    }
}
