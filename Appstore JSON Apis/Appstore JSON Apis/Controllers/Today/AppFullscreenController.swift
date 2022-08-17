//
//  AppFullscreenController.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 18.08.2022.
//

import UIKit

class AppFullscreenController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0{
            return AppFullscreenHeaderCell()
        }
        let cell = AppFullscreenDescriptionCell()
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}