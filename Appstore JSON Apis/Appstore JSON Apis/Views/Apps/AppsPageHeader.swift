//
//  AppsPageHeader.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 30.07.2022.
//

import UIKit

class AppsPageHeader: UICollectionReusableView{
    
    let appHeaderHorizontalController = AppHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(appHeaderHorizontalController.view)
        appHeaderHorizontalController.view.fillSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
