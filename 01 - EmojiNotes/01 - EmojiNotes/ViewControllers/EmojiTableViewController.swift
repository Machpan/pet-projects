import UIKit

final class EmojiTableViewController: UITableViewController {
    
    private var objects = [Objects(emoji: "😱", title: "Срочно", description: "купить книжки", isFavourite: false),
                   Objects(emoji: "😼", title: "Купить корм кошке", description: "", isFavourite: false),
                   Objects(emoji: "🦶🏻", title: "Поехать на дачу", description: "Взять всё с собой", isFavourite: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Emoji notes"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSegue(unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == Constants.saveButtonSegueID else { return }
        let sourceViewController = unwindSegue.source as! NewRowTableViewController
        let newObject = sourceViewController.newObject
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            objects[selectedIndexPath.row] = newObject
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else{
            let newindexPath = IndexPath(item: objects.count, section: 0)
            objects.append(newObject)
            tableView.insertRows(at: [newindexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == Constants.editCellSegueID else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let object = objects[indexPath.row]
        let navVC = segue.destination as! UINavigationController
        let newRowVC = navVC.topViewController as! NewRowTableViewController
        newRowVC.newObject = object
        newRowVC.title = "Edit"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { objects.count }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool { true}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.setValues(object: object)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        objects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedObject = objects.remove(at: fromIndexPath.row)
        objects.insert(movedObject, at: to.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
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
        }
        action.backgroundColor = object.isFavourite ? .purple : .gray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
