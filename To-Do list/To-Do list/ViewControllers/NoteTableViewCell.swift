//
//  NoteTableViewCell.swift
//  To-Do list
//
//  Created by Владимир Осипов on 03.07.2022.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    static let identifire = "noteCell"
    let flagLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(40)
        label.contentMode = .center
        label.frame = CGRect(x: 10, y: 0, width: 70, height: 70)
        return label
    }()
    var titleLabel = UILabel()
    let descriptionLabel = UILabel()
    var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(object: Objects){
        flagLabel.text = object.flag
        titleLabel.text = object.title
        descriptionLabel.text = object.description
        let lightPinkColor = UIColor(red: 1, green: 0.77, blue: 0.87, alpha: 1)
        self.contentView.backgroundColor = object.isFavourite ? lightPinkColor : .white
    }
    func createLabels(){
        contentView.addSubview(flagLabel)
        stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.frame = CGRect(x: 70, y: 0, width: 300, height: 70)
        contentView.addSubview(stackView)
    }
}
