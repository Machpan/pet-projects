//
//  TodayItem.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 19.08.2022.
//

import UIKit

struct TodayItem{
    
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    let cellType: CellType
    enum CellType: String {
        case single, multiple
    }
}
