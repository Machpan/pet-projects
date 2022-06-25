import UIKit

final class EmojiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setValues(object: Objects){
        emojiLabel.text = object.emoji
        titleLabel.text = object.title
        descriptionLabel.text = object.description
    }
}
