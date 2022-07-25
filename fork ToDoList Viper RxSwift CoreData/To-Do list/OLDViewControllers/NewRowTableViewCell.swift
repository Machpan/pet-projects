//
//  NewRowTableViewCell.swift
//  To-Do list
//
//  Created by Владимир Осипов on 06.07.2022.
//

import UIKit
import SnapKit

final class NewRowTableViewCell: UITableViewCell {
    //идентификатор для ячейки, св-во класса
    static let identifire = "newRowCell"
    public let textField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //верстка ткстового поля
    private func createTextField(){
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        contentView.addSubview(textField)
        contentView.backgroundColor = .systemGroupedBackground
        textField.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
