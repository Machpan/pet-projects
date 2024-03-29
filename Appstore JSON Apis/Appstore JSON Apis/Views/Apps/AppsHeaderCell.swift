//
//  AppsHeaderCell.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 30.07.2022.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell{
    
    let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    var titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
    let imageView = UIImageView(cornerRadius: 8)
    var app: SocialApp! {
        didSet {
            companyLabel.text = app.name
            titleLabel.text = app.tagline
            imageView.sd_setImage(with: URL(string: app.imageUrl))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.image = UIImage(named: "holiday")
        companyLabel.textColor = .blue
        titleLabel.numberOfLines = 2
        let stackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0 ))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
