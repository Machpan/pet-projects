//
//  ReviewRowCell.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 16.08.2022.
//

import UIKit

class ReviewRowCell: UICollectionViewCell{
    
    let reviewsController = ReviewsController()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .yellow
        addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
