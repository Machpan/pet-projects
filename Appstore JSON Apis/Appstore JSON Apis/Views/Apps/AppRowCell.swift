//
//  AppRowCell.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 30.07.2022.
//

import UIKit

class AppRowCell: UICollectionViewCell{
    
    let imageView: UIImageView = UIImageView(cornerRadius: 8)
    let nameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")
    var app: FeedResult! {
        didSet {
            companyLabel.text = app.name
            nameLabel.text = app.name
            imageView.sd_setImage(with: URL(string: app.artworkUrl100))
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        imageView.backgroundColor = .purple
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 32 / 2
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        let stackView = UIStackView(arrangedSubviews: [imageView,
                                                       VerticalStackView(arrangedSubviews: [nameLabel, companyLabel]),
                                                       getButton])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

