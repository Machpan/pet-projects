//
//  SearchAppsViewController.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 20.07.2022.
//

import UIKit
import SDWebImage

final class AppsSearchController: BaseListController {
    
    fileprivate let cellId = "appsSearchID"
    fileprivate var appResults = [Result]()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    var timer: Timer?
    fileprivate let enterSearchTermlabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        //fetchItunesApps()
        setupSearchBar()
        collectionView.addSubview(enterSearchTermlabel)
        enterSearchTermlabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
    }
    
    fileprivate func fetchItunesApps(){
        Service.shared.fetchApps(searchTerm: "apple") { (res, err) in
            if let _ = err {
                return
            }
            self.appResults = res?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    fileprivate func setupSearchBar(){
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermlabel.isHidden = appResults.count != 0
        return appResults.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.appResult = appResults[indexPath.item]
        return cell
    }
}
extension AppsSearchController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 350)
    }
}
extension AppsSearchController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            Service.shared.fetchApps(searchTerm: searchText) { (res, err) in
                self.appResults = res?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
}
