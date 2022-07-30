//
//  Extensions.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 30.07.2022.
//

import UIKit

extension UILabel{
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}
extension UIImageView{
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
extension UIButton{
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
