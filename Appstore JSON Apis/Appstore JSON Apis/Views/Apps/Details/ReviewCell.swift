//
//  ReviewCell.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 16.08.2022.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titlelabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach { (_) in
            let imageView = UIImageView(image: UIImage(named: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        }
        arrangedSubviews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    let bodyLabel = UILabel(text: "Review body", font: .systemFont(ofSize: 18), numberOfLines: 8)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9364743829, green: 0.933059752, blue: 0.9717808366, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        let stackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titlelabel, authorLabel], customSpacing: 8),
                                                             starsStackView,
                                                             bodyLabel], spacing: 12)
        titlelabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
