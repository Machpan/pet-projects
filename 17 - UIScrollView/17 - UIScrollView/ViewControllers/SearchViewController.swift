import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let (searchLabel, recentlyWatchedLabel, requestslabel) = (UILabel(), UILabel(), UILabel())
    private let searchTextField = UITextField()
    //тёмно-серый фон для объектов
    let backgroundColorForObjects = UIColor(red: 0.07, green: 0.09, blue: 0.1, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTitleLabels(label: searchLabel, text: "Поиск", fontSize: 35)
        createTitleLabels(label: recentlyWatchedLabel, text: "Недавно просмотренные", fontSize: 22)
        createTitleLabels(label: requestslabel, text: "Варианты запросов", fontSize: 22)
        createSearchTextField()
        
        makeConstraints()
    }
    //Задаём повторяющиеся параметры для лейблов
    private func createTitleLabels(label: UILabel, text: String, fontSize: CGFloat){
        label.text = text
        label.font = UIFont(name: "Helvetica-Bold", size: fontSize)
        label.textColor = .white
        view.addSubview(label)
    }

    //Вёрстка текстового поля
    private func createSearchTextField(){
        searchTextField.backgroundColor = backgroundColorForObjects
        searchTextField.attributedPlaceholder = NSAttributedString(string: "\u{1F50D} Поиск по продуктам и магазинам", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        searchTextField.textColor = .lightGray
        searchTextField.layer.cornerRadius = 8
        view.addSubview(searchTextField)
        
    }
    //скрываем клавиатуру по тапу на вью
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: Констрейнты
extension SearchViewController{
    private func makeConstraints(){
        searchLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(30)
        }
        searchTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(searchLabel).inset(50)
            make.height.equalTo(40)
        }
        recentlyWatchedLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField).inset(80)
            make.left.equalToSuperview().inset(16)
        }
    }
}
//createScrollView()
//createQueryOptionsButtons()
//collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: Constants.collectionViewCellID)
//collectionView.dataSource = self
//collectionView.delegate = self
//let layout =  UICollectionViewFlowLayout()
//layout.scrollDirection = .horizontal
//self.collectionView.collectionViewLayout = layout
//
//    let collectionView = UICollectionView()
//    //отступы для CollectionView
//    let itemsPerRow: CGFloat = 3
//    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

//    //голубой цвет для кнопок
//    let tintColorForButtons = UIColor(red: 0.37, green: 0.78, blue: 0.9, alpha: 1)
//
//    //варианты запросов
//    let queryOptions = ["AirPods", "AppleCare", "Beats", "Сравните модели iPhone"]
//    //создаем объекты на скролл-вью
//    var recentlyWatchedObjects = [Product(price: 990, description: "Силиконовый чехол для iPhone 8-13", productPhoto: ["iphone" ,"1", "2", "3"], webPage: "pikabu.ru"),
//                                  Product(price: 2300, description: "Чехол для MacBook Pro m1", productPhoto: ["macbook", "mb1", "mb2", "mb3"], webPage: "yandex.ru"),
//                                  Product(price: 4800, description: "Кожаный ремешок для Apple Watch series", productPhoto: ["iwatch", "w1", "w2", "w3"], webPage: "mobile-review.com"),
//                                  Product(price: 2400, description: "Противоударный чехол для iPad", productPhoto: ["ipad", "ipad1", "ipad2", "ipad3"], webPage: "rutube.com")]
//
//


//    //вёрстка ScrollView -> View -> ImageView + label
//    func createScrollView(){
//        var startXForView = 0
//        //фрейм для скроллВью
//        let recentlyViewFrame = CGRect(x: startXForView, y: 0, width: 128, height: 162)
//        collectionView.frame = CGRect(x: 20, y: 303, width: 374, height: 175)
//        //размер соответствует фрейму * количество товара в базе + 10px между товаром
//        collectionView.contentSize = CGSize(width: (recentlyViewFrame.width * CGFloat(recentlyWatchedObjects.count)) + CGFloat((recentlyWatchedObjects.count * 10)),
//                                        height: recentlyViewFrame.height)
//        //пробегаемся в цикле по базе товаров с индексом
//        for (tag, base) in recentlyWatchedObjects.enumerated(){
//            let viewForOneObject = UIView()
//            let imageView = UIImageView()
//            let label = UILabel()
//            //верстаем вью
//            viewForOneObject.backgroundColor = backgroundColorForObjects
//            viewForOneObject.layer.cornerRadius = 10
//            viewForOneObject.frame = CGRect(x: startXForView, y: 0, width: 128, height: 162)
//            //верстаем imageView
//            imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 100)
//            imageView.contentMode = .scaleAspectFit
//            if let image = base.productPhoto[0]{
//                imageView.image = UIImage(named: image)
//            }
//            //верстаем лейбл
//            label.frame = CGRect(x: 8, y: 110, width: 112, height: 45)
//            //текст берем из модели
//            label.text = base.description
//            label.textColor = .white
//            label.font = requestslabel.font.withSize(12)
//            label.numberOfLines = 0
//            //добавляем картинку и лейбл на вью
//            viewForOneObject.addSubview(imageView)
//            viewForOneObject.addSubview(label)
//            //Вью имеет тег для экшена
//            viewForOneObject.tag = tag
//            //создаем наблюдаеля за тапами
//            let recognizer = UITapGestureRecognizer()
//            recognizer.addTarget(self, action: #selector(tapForViewAction(_:)))
//            viewForOneObject.addGestureRecognizer(recognizer)
//            //добавляем вью на скролл вью по очереди
//
//            //перемещаем координату Х для следующего вью
//            startXForView += Int(viewForOneObject.bounds.width) + 10
//        }
//        view.addSubview(collectionView)
//    }
//    //тап по пью
//    @objc func tapForViewAction(_ gestureRecognizer: UITapGestureRecognizer) {
////        //запоминаем индекс вью
////        let productIndex = gestureRecognizer.view?.tag
////        //переходим на следующий экран
////        let productPage = ProductPageViewController()
////        //кидаем туда картинки, стоимость товара и описание товара
////        productPage.productTitleLabelValue = recentlyWatchedObjects[productIndex ?? 0].description
////        productPage.priceLabelValue = String(recentlyWatchedObjects[productIndex ?? 0].price)
////        productPage.viewTag = productIndex ?? 0
////
////        self.navigationController?.pushViewController(productPage, animated: true)
//    }
//
//    //верстка кнопок Варианты запросов
//    func createQueryOptionsButtons(){
//        var startY = 550
//        for query in queryOptions{
//            let button = UIButton()
//
//            button.frame = CGRect(x: 0, y: startY, width: Int(view.bounds.width), height: 32)
//            button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
//            button.setTitle(" " + query, for: .normal)
//            button.setTitleColor(.white, for: .normal)
//            button.contentHorizontalAlignment = .left
//            button.imageView?.tintColor = .lightGray
//            button.titleLabel?.font = UIFont(name: "Helvetica", size: 18)
//
//            let bottomLine = CALayer()
//            bottomLine.frame = CGRect(x: 0.0, y: button.frame.height + 5, width: button.frame.width, height: 1.0)
//            bottomLine.backgroundColor = backgroundColorForObjects.cgColor
//            button.layer.addSublayer(bottomLine)
//
//            self.view.addSubview(button)
//            startY += 50
//        }
//    }
//}

//extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate{
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellID, for: indexPath) as? ProductCollectionViewCell{
//            let product = recentlyWatchedObjects[indexPath]
//            cell.productValue = recentlyWatchedObjects[indexPath]
//            return cell
//        }
//        return UICollectionViewCell()
//    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return recentlyWatchedObjects.count
//    }

//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
//
//        let imageName = photos[indexPath.item]
//        let image = UIImage(named: imageName)
//
//        cell.dogImageView.image = image
//
//        return cell
//    }
    
//}
//extension SearchViewController: UICollectionViewDelegateFlowLayout{
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
//        let availableWidth = collectionView.frame.width - paddingWidth
//        let widthPerItem = availableWidth / itemsPerRow
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInserts
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInserts.left
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInserts.left
//    }
//}
