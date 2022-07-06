//
//  MainScreenTableViewController.swift
//  To-Do list
//
//  Created by Владимир Осипов on 03.07.2022.
//

import UIKit
//Протокол делегада для создания новой строки
protocol MainScreenViewControllerDelegate: AnyObject {
    func updateTableView(_ newObject: Objects, isNewRow: Bool)
}

final class MainScreenViewController: UIViewController{
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifire)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    var objects = [Objects(flag: "😱", title: "Срочно", description: "купить книжки", isFavourite: false),
                   Objects(flag: "😼", title: "Купить корм кошке", description: "", isFavourite: false),
                   Objects(flag: "🦶🏻", title: "Поехать на дачу", description: "Взять всё с собой", isFavourite: false)]
    var selectedRow = IndexPath()
    
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
    //BarButtons
    func createBarButtonitems() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTableView))
        let addNewRow = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewRow))
        self.navigationItem.leftBarButtonItem = editButton
        self.navigationItem.rightBarButtonItem = addNewRow
    }
    @objc func editTableView(){
        tableView.isEditing = !tableView.isEditing
    }
    @objc func addNewRow(){
        let newRowViewController = NewRowViewController()
        let navigationController = UINavigationController(rootViewController: newRowViewController)
        newRowViewController.isNewRow = true
        newRowViewController.delegate = self
        self.present(navigationController, animated: true, completion: nil)
    }
}

//MARK: UITableViewDataSource, UITableViewDelegate
extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate{
    //количество секций
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    //количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { objects.count }
    //создаём секцию
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifire, for: indexPath) as? NoteTableViewCell else { return UITableViewCell()}
        let object = objects[indexPath.row]
        cell.setValues(object: object)
        return cell
    }
    //высота строки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 70 }
    //перемещение ячеек
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedObject = objects.remove(at: fromIndexPath.row)
        objects.insert(movedObject, at: to.row)
        tableView.reloadData()
    }
    //две свайп-кнопки
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneButton(at: indexPath)
        let favourite = favouriteButtn(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    //экшен для кнопки done
    private func doneButton(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .green
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    //экшен для кнопки Favourite
    private func favouriteButtn(at indexPath: IndexPath) -> UIContextualAction{
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
            self.tableView.reloadData()
        }
        action.backgroundColor = object.isFavourite ? .purple : .gray
        action.image = UIImage(systemName: "heart")
        return action
    }
    //разрешение для перемещения
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool { true}
    //удаление ячейки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        objects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    //выбор строки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //переходим на следующий экран
        let newRowViewController = NewRowViewController()
        let navigationController = UINavigationController(rootViewController: newRowViewController)
        selectedRow = indexPath
        let object = objects[indexPath.row]
        newRowViewController.newObject = object
        newRowViewController.isNewRow = false
        newRowViewController.delegate = self
        self.present(navigationController, animated: true, completion: nil)
    }
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
