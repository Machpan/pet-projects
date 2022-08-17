//
//  ReviewsController.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 16.08.2022.
//

import UIKit

class ReviewsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    var reviews: Reviews?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviews?.feed.entry.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewCell
        let entry = self.reviews?.feed.entry[indexPath.item]
        cell.titlelabel.text = entry?.title.label
        cell.authorLabel.text = entry?.author.name.label
        cell.bodyLabel.text = entry?.content.label
        for (index, view) in cell.starsStackView.arrangedSubviews.enumerated(){
            if let ratingInt = Int(entry!.rating.label){
                view.alpha = index >= ratingInt ? 0 : 1
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width - 48, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}
