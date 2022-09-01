//
//  NotificationsViewController.swift
//  Awfarlak
//
//  Created by Ahmed Madeh on 02/06/2022.
//

import UIKit

class NotificationsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var model = PagedObject<NotificationModel>()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "notifications".localized
        tableView.registerCell(ofType: NotificationTableViewCell.self)
        loadNotifications()
    }
    
    func loadNotifications() {
        Hud.show()
        APIs.loadNotifications(page: model.nextPage).done { [weak self] in
            self?.model.append($0)
            self?.tableView.reloadData()
        }.catch {
            Alert.show(message: $0.localizedDescription)
        }.finally {
            Hud.hide()
        }
    }
    
    // MARK: - Actions

}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { model.items.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 140 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationTableViewCell = tableView.dequeueReusableCell()!
        cell.notificationTitle.text = model.items[indexPath.row].title
        cell.notificationDesc.text = model.items[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if model.hasNext(indexPath) {
            loadNotifications()
        }
    }
        
}
