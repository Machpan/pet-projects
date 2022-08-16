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
    let bodyLabel = UILabel(text: "Review body", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9364743829, green: 0.933059752, blue: 0.9717808366, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titlelabel, UIView(), authorLabel]),
                                                             starsLabel,
                                                             bodyLabel], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
