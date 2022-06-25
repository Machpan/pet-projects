import UIKit

final class NewRowTableViewController: UITableViewController {
    @IBOutlet weak var emojiTextFied: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var newObject = Objects(emoji: "", title: "", description: "", isFavourite: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        updateUI()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == Constants.saveButtonSegueID else { return }
        let emojiText = emojiTextFied.text ?? ""
        let titleText = titleTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        newObject = Objects(emoji: emojiText, title: titleText, description: descriptionText, isFavourite: self.newObject.isFavourite)
    }

    private func updateSaveButtonState(){
        let emojiText = emojiTextFied.text ?? ""
        let titleText = titleTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        saveButton.isEnabled = !emojiText.isEmpty && !titleText.isEmpty && !descriptionText.isEmpty
    }
    
    private func updateUI(){
        emojiTextFied.text = newObject.emoji
        titleTextField.text = newObject.title
        descriptionTextField.text = newObject.description
    }
}
