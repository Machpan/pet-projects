//
//  MainScreenTableViewController.swift
//  To-Do list
//
//  Created by Владимир Осипов on 03.07.2022.
//

import UIKit

final class MainScreenViewController: UIViewController{
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifire)
        return tableView
    }()
    var objects = [Objects(flag: "😱", title: "Срочно", description: "купить книжки", isFavourite: false),
                           Objects(flag: "😼", title: "Купить корм кошке", description: "", isFavourite: false),
                           Objects(flag: "🦶🏻", title: "Поехать на дачу", description: "Взять всё с собой", isFavourite: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To-Do list"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { objects.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifire, for: indexPath) as? NoteTableViewCell else { return UITableViewCell()}
        let object = objects[indexPath.row]
        cell.setValues(object: object)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 70 }
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedObject = objects.remove(at: fromIndexPath.row)
        objects.insert(movedObject, at: to.row)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneButton(at: indexPath)
        let favourite = favouriteButtn(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    
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
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool { true}
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        objects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}
