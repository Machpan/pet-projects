//
//  ProductCollectionViewCell.swift
//  17 - UIScrollView
//
//  Created by Владимир Осипов on 25.06.2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    let productImageView = UIImageView()
    let productLabel = UILabel()
    
    var productValue: Product?{
        didSet{
            productLabel.text = productValue?.description
            if let image = productValue?.productPhoto[0]{
                productImageView.image = UIImage(named: image)
            }
        }
    }
}
