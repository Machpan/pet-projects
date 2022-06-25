//
//  Model.swift
//  17 - UIScrollView
//
//  Created by Владимир Осипов on 28.05.2022.
//

import UIKit

let model = Model()

class Model: NSObject {
    //тёмно-серый фон для объектов
    let backgroundColorForObjects = UIColor(red: 0.07, green: 0.09, blue: 0.1, alpha: 1)
    //голубой цвет для кнопок
    let tintColorForButtons = UIColor(red: 0.37, green: 0.78, blue: 0.9, alpha: 1)
    //описание и картинка товара
    let recentlyWatched: [(descriptionText: String, image: UIImage?)] = [("Силиконовый чехол для iPhone 8-13", UIImage(named: "iphone")),
                                                                         ("Противоударный чехол для iPad", UIImage(named: "macbook")),
                                                                         ("Кожаный ремешок для Apple Watch series", UIImage(named: "iwatch")),
                                                                         ("Противоударный чехол для iPad", UIImage(named: "ipad"))]
    //база последних запросов
    let queryOptions = ["AirPods", "AppleCare", "Beats", "Сравните модели iPhone"]
    //стоимость товара, индекс соответствует recentlyWatched
    let price = [990, 2300, 4800, 2400]
    //словарь с товаром и его картинками
    let productPhoto = ["iphone": [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3")],
                        "macbook": [UIImage(named: "mb1"), UIImage(named: "mb2"), UIImage(named: "mb3")],
                        "iwatch": [UIImage(named: "w1"), UIImage(named: "w2"), UIImage(named: "w3")],
                        "ipad": [UIImage(named: "ipad1"), UIImage(named: "ipad2"), UIImage(named: "ipad3")]]
    let webPages = [0: "pikabu.ru", 1: "yandex.ru", 2: "mobile-review.com", 3: "rutube.com"]
}


struct Model2{
    let price: Int
    let imageName: String
    let description: String
    let pdoductPhoto: [String: [String?]]
    let webPage: String
}
