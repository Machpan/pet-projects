//
//  MusicLoadingFooter.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 28.08.2022.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        let label = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
        label.textAlignment = .center
        let stackView = VerticalStackView(arrangedSubviews: [aiv, label], spacing: 8)
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
