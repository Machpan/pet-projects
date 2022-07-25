//
//  MainScreenTableViewController.swift
//  To-Do list
//
//  Created by Владимир Осипов on 03.07.2022.
//

import UIKit
//Протокол делегата для создания новой строки
protocol MainScreenViewControllerDelegate: AnyObject {
    func updateTableView(_ newObject: Objects, isNewRow: Bool)
}

final class MainScreenViewController: UIViewController{
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifire)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    private var objects = [Objects(flag: "😱", title: "Срочно", description: "купить книжки", isFavourite: false),
                   Objects(flag: "😼", title: "Купить корм кошке", description: "", isFavourite: false),
                   Objects(flag: "🦶🏻", title: "Поехать на дачу", description: "Взять всё с собой", isFavourite: false)]
    private var selectedRow = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To-Do list"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        createBarButtonitems()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

//MARK: UITableViewDataSource, UITableViewDelegate
extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate{
    
}

//MARK: Передача данных обратно
extension MainScreenViewController: MainScreenViewControllerDelegate{
    func updateTableView(_ newObject: Objects, isNewRow: Bool) {
        if isNewRow{
            objects.append(newObject)
            let newIndexPath = IndexPath(item: objects.count - 1, section: 0)
            self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            tableView.reloadData()
        } else {
            objects[selectedRow.row] = newObject
            tableView.reloadRows(at: [selectedRow], with: .fade)
        }
    }
}
