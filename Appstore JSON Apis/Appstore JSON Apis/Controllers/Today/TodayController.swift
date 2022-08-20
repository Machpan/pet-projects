//
//  TodayController.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 17.08.2022.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    static let cellSize: CGFloat = 500
    var startingFrame: CGRect?
    var appFullscreenController: AppFullscreenController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var items = [TodayItem]()
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        fetchData()
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = #colorLiteral(red: 0.94892627, green: 0.9490850568, blue: 0.9489052892, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    }
    
    fileprivate func fetchData(){
        var topGrossingGroup: AppGroup?
        var topFreeGroup: AppGroup?
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { appGroup, err in
            topGrossingGroup = appGroup
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        Service.shared.fetchTopFree { appGroup, err in
            topFreeGroup = appGroup
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            self.items = [TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: UIImage(named: "garden")!, description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
                          TodayItem.init(category: "Daily List", title: topFreeGroup?.feed.title ?? "", image: UIImage(named: "garden")!, description: "", backgroundColor: .white, cellType: .multiple, apps: topFreeGroup?.feed.results ?? []),
                          TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: UIImage(named: "garden")!, description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
                          TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: UIImage(named: "holiday")!, description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9779213071, green: 0.9627225995, blue: 0.723952651, alpha: 1), cellType: .single, apps: [])]
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = items[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        (cell as? TodayMultipleAppCell)?.multipleAppController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap(gesture:))))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if items[indexPath.item].cellType == .multiple{
            let fullController = TodayMultipleAppsController(mode: .fullscreen)
            fullController.apps = self.items[indexPath.item].apps
            present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
            return
        }
        let appFullscreenController = AppFullscreenController()
        appFullscreenController.todayItem = items[indexPath.row]
        let fullscreenController = appFullscreenController.view!
        fullscreenController.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        view.addSubview(fullscreenController)
        addChild(appFullscreenController)
        self.appFullscreenController = appFullscreenController
        self.collectionView.isUserInteractionEnabled = false
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        fullscreenController.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullscreenController.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullscreenController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullscreenController.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullscreenController.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({ $0?.isActive = true})
        view.layoutIfNeeded()
        fullscreenController.layer.cornerRadius = 16
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 60
            cell.layoutIfNeeded()
        }, completion: nil)
    }
    @objc func handleRemoveRedView(gesture: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            self.appFullscreenController.tableView.contentInset = .zero
            guard let startingFrame = self.startingFrame else { return }
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
        } completion: { _ in
            gesture.view?.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        }
    }
    @objc fileprivate func handleMultipleAppsTap(gesture: UITapGestureRecognizer){
        let collectionView = gesture.view
        var superview = collectionView?.superview
        while superview != nil {
            if let cell = superview as? TodayMultipleAppCell{
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                let apps = self.items[indexPath.item].apps
                let fullController = TodayMultipleAppsController(mode: .fullscreen)
                fullController.apps = apps
                present(fullController, animated: true)
                return
            }
            superview = superview?.superview
        }
    }
}
