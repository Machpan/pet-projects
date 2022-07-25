//
//  MainViewController.swift
//  To-Do list
//
//  Created by Владимир Осипов on 25.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let tableView = TasksTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To-Do list"
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    //BarButtons
    private func createBarButtonitems() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTableView))
        let addNewRow = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewRow))
        self.navigationItem.leftBarButtonItem = editButton
        self.navigationItem.rightBarButtonItem = addNewRow
    }
    @objc private  func editTableView(){
        tableView.isEditing = !tableView.isEditing
    }
    @objc private  func addNewRow(){
        let newRowViewController = NewRowViewController()
        let navigationController = UINavigationController(rootViewController: newRowViewController)
        newRowViewController.isNewRow = true
        newRowViewController.delegate = self
        self.present(navigationController, animated: true, completion: nil)
    }
}
