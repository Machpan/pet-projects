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
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<AppSection, AnyHashable> = .init(collectionView: self.collectionView) { (collectionView, indexPath, object) in
        if let object = object as? SocialApp{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AppsHeaderCell
            cell.app = object
            return cell
        }
        return nil
    }
    
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
        setupDiffableDatasource()
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        0
    }
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
        collectionView.dataSource = diffableDataSource
        Service.shared.fetchSocialApps { (socialApps, err) in
            Service.shared.fetchTopFree { (appGroup, err) in
                var snapshot = self.diffableDataSource.snapshot()
                snapshot.appendSections([.topSocial])
                snapshot.appendItems(socialApps ?? [], toSection: .topSocial)
                snapshot.appendSections([.topFree])
                let objects = appGroup?.feed.results ?? []
                snapshot.appendItems(objects ?? [], toSection: .topFree)
                self.diffableDataSource.apply(snapshot)
            }
            
        }
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
