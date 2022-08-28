//
//  AppsCompositionalView.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 28.08.2022.
//

import SwiftUI

class CompositionalController: UICollectionViewController{
    
    class CompositionalHeader: UICollectionReusableView {
        
        let label = UILabel(text: "Top free apps", font: .boldSystemFont(ofSize: 32))
        
        override init(frame: CGRect){
            super.init(frame: frame)
            addSubview(label)
            label.fillSuperview()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    enum AppSection {
        case topSocial
        case topFree
    }
    
    let headerId = "headerId"
    var socialApps = [SocialApp]()
    var topFree: AppGroup?
    var topGross: AppGroup?
    var topGrossEn: AppGroup?
    
    init(){
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) in
            if sectionNumber == 0{
                return CompositionalController.topSection()
            } else{
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets.leading = 16
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: kind, alignment: .topLeading)]
                return section
            }
        }
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: "smallCellId")
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
//        fetchApps()
        setupDiffableDatasource()
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0{
//            return socialApps.count
//        } else if section == 1{
//            return topFree?.feed.results.count ?? 0
//        } else if section == 2{
//            return topGross?.feed.results.count ?? 0
//        } else{
//            return topGrossEn?.feed.results.count ?? 0
//        }
//    }
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch indexPath.section{
//        case 0:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AppsHeaderCell
//            let socialApp = self.socialApps[indexPath.item]
//            cell.titleLabel.text = socialApp.tagline
//            cell.companyLabel.text = socialApp.name
//            cell.imageView.sd_setImage(with: URL(string: socialApp.imageUrl))
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallCellId", for: indexPath) as! AppRowCell
//            var appGroup : AppGroup?
//            if indexPath.section == 1{
//                appGroup = topFree
//            } else if indexPath.section == 2{
//                appGroup = topGross
//            } else{
//                appGroup = topGrossEn
//            }
//            cell.app = appGroup?.feed.results[indexPath.item]
//            return cell
//        }
//    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CompositionalHeader
        var title: String?
        if indexPath.section == 1{
            title = topFree?.feed.title
        } else if indexPath.section == 2{
            title = topGross?.feed.title
        } else{
            title = topGrossEn?.feed.title
        }
        header.label.text = title
        return header
    }
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let appId: String
//        if indexPath.section == 0{
//            appId = socialApps[indexPath.item].id
//        } else if indexPath.section == 1{
//            appId = topFree?.feed.results[indexPath.item].id ?? ""
//        } else if indexPath.section == 2{
//            appId = topGross?.feed.results[indexPath.item].id ?? ""
//        } else {
//            appId = topGrossEn?.feed.results[indexPath.item].id ?? ""
//        }
//        let appDetailController = AppDetailController(appId: appId)
//        navigationController?.pushViewController(appDetailController, animated: true)
//    }
    static func topSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.bottom = 16
        item.contentInsets.trailing = 16
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.leading = 32
        return section
    }
    private func fetchApps(){
        Service.shared.fetchSocialApps { (apps, err) in
            self.socialApps = apps ?? []
            Service.shared.fetchTopFree { (appGroup, err) in
                self.topFree = appGroup
                Service.shared.fetchTopGrossing { (appGroup, err) in
                    self.topGross = appGroup
                    Service.shared.fetchAppGroup(urlString: "https://rss.applemarketingtools.com/api/v2/ne/apps/top-paid/10/apps.json") { (appGroup, err) in
                        self.topGrossEn = appGroup
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    private func setupDiffableDatasource(){
        let diffableDataSource: UICollectionViewDiffableDataSource<AppSection, SocialApp> = .init(collectionView: self.collectionView) { (collectionView, indexPath, socialApp) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AppsHeaderCell
            return cell
        }
        var snapshot = diffableDataSource.snapshot()
        snapshot.appendSections([.topSocial])
        snapshot.appendItems([SocialApp(id: "id0", name: "name0", imageUrl: "image1", tagline: "tagline0")], toSection: .topSocial)
        diffableDataSource.apply(snapshot)
        collectionView.dataSource = diffableDataSource
    }
}


struct AppsView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CompositionalController()
        return UINavigationController(rootViewController: controller)
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    typealias UIViewControllerType = UIViewController
}

struct AppsCompositionalView_Previews: PreviewProvider {
    
    static var previews: some View {
        AppsView()
            .edgesIgnoringSafeArea(.all)
            .previewInterfaceOrientation(.portrait)
    }
}
