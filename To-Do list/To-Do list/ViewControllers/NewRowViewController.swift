//
//  NewRowViewController.swift
//  To-Do list
//
//  Created by Владимир Осипов on 06.07.2022.
//

import UIKit

class NewRowViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(NewRowTableViewCell.self, forCellReuseIdentifier: NewRowTableViewCell.identifire)
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        return tableView
    }()
    let titles = ["symbol", "title", "description"]
    var newObject = Objects(flag: "", title: "", description: "", isFavourite: false)
    weak var delegate: MainScreenViewControllerDelegate?
    var isNewRow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "add a new task"
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        createBarButtonitems()
    }
    
    //BarButtons
    func createBarButtonitems() {
        let canselButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(canselButtonAction))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonAction))
        self.navigationItem.leftBarButtonItem = canselButton
        self.navigationItem.rightBarButtonItem = saveButton
    }
    @objc func canselButtonAction(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    @objc func saveButtonAction(){
        guard let indexPath = tableView.indexPathsForVisibleRows else { return }
        for (row, index) in indexPath.enumerated(){
            if let cell = tableView.cellForRow(at: index) as? NewRowTableViewCell{
                switch row{
                case 0: newObject.flag = cell.textField.text ?? ""
                case 1: newObject.title = cell.textField.text ?? ""
                case 2: newObject.description = cell.textField.text ?? ""
                default: break
                }
            }
        }
        delegate?.updateTableView(newObject, isNewRow: isNewRow)
        isNewRow = false
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension NewRowViewController: UITableViewDelegate, UITableViewDataSource{
    //количество секций
    func numberOfSections(in tableView: UITableView) -> Int { titles.count }
    //количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    //заголовки
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { titles[section] }
    //создаём секцию
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewRowTableViewCell.identifire, for: indexPath) as? NewRowTableViewCell else { return UITableViewCell()}
        cell.largeContentTitle = titles[indexPath.row]
        let symbol = newObject.flag
        let title = newObject.title
        let description = newObject.description
        let valuesArray = [symbol, title, description]
        cell.textField.text = valuesArray[indexPath.section]
        return cell
    }
}

