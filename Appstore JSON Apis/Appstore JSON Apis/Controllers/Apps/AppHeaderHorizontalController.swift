//
//  AppHeaderHorizontalController.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 30.07.2022.
//

import UIKit

class AppHeaderHorizontalController: BaseListController, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width - 48, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 0)
    }
}
