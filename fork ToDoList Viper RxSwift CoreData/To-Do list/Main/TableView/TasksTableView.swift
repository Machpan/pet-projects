//
//  TasksTableView.swift
//  To-Do list
//
//  Created by Владимир Осипов on 25.07.2022.
//

import UIKit

class TasksTableView: UITableView{
    
    override init(frame: CGRect, style: UITableView.Style){
        super.init(frame: frame, style: style)
        self.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifire)
        self.separatorStyle = .singleLine
        self.dataSource = TasksTableView
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
