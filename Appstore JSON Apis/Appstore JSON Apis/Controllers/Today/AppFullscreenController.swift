//
//  AppFullscreenController.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 18.08.2022.
//

import UIKit

class AppFullscreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dismissHandler: (() ->())?
    var todayItem: TodayItem?
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close_button"), for: .normal)
        return button
    }()
    let tableView = UITableView(frame: .zero, style: .plain)
    let floatingContainerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        view.addSubview(tableView)
        setupCloseButton()
        setupFloatingControls()
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    fileprivate func setupFloatingControls(){
        floatingContainerView.clipsToBounds = true
        floatingContainerView.layer.cornerRadius = 16
        view.addSubview(floatingContainerView)
        floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -90, right: 16), size: .init(width: 0, height: 90))
        let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        let imageView = UIImageView(cornerRadius: 16)
        imageView.image = todayItem?.image
        imageView.constrainHeight(constant: 78)
        imageView.constrainWidth(constant: 78)
        let getButton = UIButton(title: "GET")
        getButton.setTitleColor(.white, for: .normal)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.backgroundColor = .darkGray
        getButton.layer.cornerRadius = 16
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        let stackView = UIStackView(arrangedSubviews: [imageView,
                                                       VerticalStackView(arrangedSubviews: [UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18)),
                                                                                            UILabel(text: "Utilizing your Time", font: .systemFont(ofSize: 16))], spacing: 4),
                                                      getButton], customSpacing: 16)
        floatingContainerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        stackView.alignment = .center
    }
    fileprivate func setupCloseButton(){
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
        closeButton.addTarget(self, action: #selector(handleDismiss(button:)), for: .touchUpInside)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0{
            let headerCell = AppFullscreenHeaderCell()
            headerCell.todayCell.todayItem = todayItem
            headerCell.todayCell.layer.cornerRadius = 0
            headerCell.clipsToBounds = true
            headerCell.todayCell.backgroundView = nil
            return headerCell
        }
        let cell = AppFullscreenDescriptionCell()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return TodayController.cellSize
        }
        return UITableView.automaticDimension
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0{
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
        let translationY: CGFloat = -180
        let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: translationY) : .identity
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            self.floatingContainerView.transform = transform
        }
    }
    @objc func handleDismiss(button: UIButton){
        button.isHidden = true
        dismissHandler?()
    }
    @objc fileprivate func handleTap(){
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            self.floatingContainerView.transform = .init(translationX: 0, y: -180)
        }
    }
}
