//
//  BaseListController.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 29.07.2022.
//

import UIKit

class BaseListController: UICollectionViewController{
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
