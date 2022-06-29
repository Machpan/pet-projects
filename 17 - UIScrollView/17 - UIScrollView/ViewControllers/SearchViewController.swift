import UIKit

class SearchViewController: UIViewController {
    let (searchLabel, recentlyWatchedLabel, requestslabel) = (UILabel(), UILabel(), UILabel())
    let searchTextField = UITextField()
    let collectionView = UICollectionView()
    
    //тёмно-серый фон для объектов
    let backgroundColorForObjects = UIColor(red: 0.07, green: 0.09, blue: 0.1, alpha: 1)
    //голубой цвет для кнопок
    let tintColorForButtons = UIColor(red: 0.37, green: 0.78, blue: 0.9, alpha: 1)
    
    //варианты запросов
    let queryOptions = ["AirPods", "AppleCare", "Beats", "Сравните модели iPhone"]
    //создаем объекты на скролл-вью
    var recentlyWatchedObjects = [Product(price: 990, description: "Силиконовый чехол для iPhone 8-13", productPhoto: ["iphone" ,"1", "2", "3"], webPage: "pikabu.ru"),
                                  Product(price: 2300, description: "Чехол для MacBook Pro m1", productPhoto: ["macbook", "mb1", "mb2", "mb3"], webPage: "yandex.ru"),
                                  Product(price: 4800, description: "Кожаный ремешок для Apple Watch series", productPhoto: ["iwatch", "w1", "w2", "w3"], webPage: "mobile-review.com"),
                                  Product(price: 2400, description: "Противоударный чехол для iPad", productPhoto: ["ipad", "ipad1", "ipad2", "ipad3"], webPage: "rutube.com")]
                                                                   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutTitlelabel(label: searchLabel, text: "Поиск", y: 102, width: 124, height: 36, fontSize: 35)
        layoutTitlelabel(label: recentlyWatchedLabel, text: "Недавно просмотренные", y: 220, width: 280, height: 36, fontSize: 22)
        layoutTitlelabel(label: requestslabel, text: "Варианты запросов", y: 500, width: 223, height: 36, fontSize: 22)
        createSearchTextField()
        createScrollView()
        createQueryOptionsButtons()
    }
//Вёрстка текстового поля
    func createSearchTextField(){
        searchTextField.backgroundColor = backgroundColorForObjects
        searchTextField.text = "\u{1F50D} Поиск по продуктам и магазинам"
        searchTextField.textColor = .lightGray
        searchTextField.frame = CGRect(x: 20, y: 146, width: Int(view.bounds.width) - 20, height: 34)
        searchTextField.layer.cornerRadius = 8
        view.addSubview(searchTextField)
        searchTextField.addTarget(self, action: #selector(searchTextFieldAction), for: .touchDown)
    }
    //Экшен нужен, чтобы текст placeholder был светлым
    @objc func searchTextFieldAction(){
        searchTextField.text = nil
    }
    //Функция для создания лейблов
    func layoutTitlelabel(label: UILabel, text: String, y: Int, width: Int, height: Int, fontSize: CGFloat){
        label.text = text
        label.frame = CGRect(x: 20, y: y, width: width, height: height)
        label.font = UIFont(name: "Helvetica-Bold", size: fontSize)
        label.textColor = .white
        view.addSubview(label)
    }
    //вёрстка ScrollView -> View -> ImageView + label
    func createScrollView(){
        var startXForView = 0
        //фрейм для скроллВью
        let recentlyViewFrame = CGRect(x: startXForView, y: 0, width: 128, height: 162)
        collectionView.frame = CGRect(x: 20, y: 303, width: 374, height: 175)
        //размер соответствует фрейму * количество товара в базе + 10px между товаром
        collectionView.contentSize = CGSize(width: (recentlyViewFrame.width * CGFloat(recentlyWatchedObjects.count)) + CGFloat((recentlyWatchedObjects.count * 10)),
                                        height: recentlyViewFrame.height)
        //пробегаемся в цикле по базе товаров с индексом
        for (tag, base) in recentlyWatchedObjects.enumerated(){
            let viewForOneObject = UIView()
            let imageView = UIImageView()
            let label = UILabel()
            //верстаем вью
            viewForOneObject.backgroundColor = backgroundColorForObjects
            viewForOneObject.layer.cornerRadius = 10
            viewForOneObject.frame = CGRect(x: startXForView, y: 0, width: 128, height: 162)
            //верстаем imageView
            imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 100)
            imageView.contentMode = .scaleAspectFit
            if let image = base.productPhoto[0]{
                imageView.image = UIImage(named: image)
            }
            //верстаем лейбл
            label.frame = CGRect(x: 8, y: 110, width: 112, height: 45)
            //текст берем из модели
            label.text = base.description
            label.textColor = .white
            label.font = requestslabel.font.withSize(12)
            label.numberOfLines = 0
            //добавляем картинку и лейбл на вью
            viewForOneObject.addSubview(imageView)
            viewForOneObject.addSubview(label)
            //Вью имеет тег для экшена
            viewForOneObject.tag = tag
            //создаем наблюдаеля за тапами
            let recognizer = UITapGestureRecognizer()
            recognizer.addTarget(self, action: #selector(tapForViewAction(_:)))
            viewForOneObject.addGestureRecognizer(recognizer)
            //добавляем вью на скролл вью по очереди
            
            //перемещаем координату Х для следующего вью
            startXForView += Int(viewForOneObject.bounds.width) + 10
        }
        view.addSubview(collectionView)
    }
    //тап по пью
    @objc func tapForViewAction(_ gestureRecognizer: UITapGestureRecognizer) {
//        //запоминаем индекс вью
//        let productIndex = gestureRecognizer.view?.tag
//        //переходим на следующий экран
//        let productPage = ProductPageViewController()
//        //кидаем туда картинки, стоимость товара и описание товара
//        productPage.productTitleLabelValue = recentlyWatchedObjects[productIndex ?? 0].description
//        productPage.priceLabelValue = String(recentlyWatchedObjects[productIndex ?? 0].price)
//        productPage.viewTag = productIndex ?? 0
//        
//        self.navigationController?.pushViewController(productPage, animated: true)
    }
        
    //верстка кнопок Варианты запросов
    func createQueryOptionsButtons(){
        var startY = 550
        for query in queryOptions{
            let button = UIButton()
            
            button.frame = CGRect(x: 0, y: startY, width: Int(view.bounds.width), height: 32)
            button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            button.setTitle(" " + query, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.contentHorizontalAlignment = .left
            button.imageView?.tintColor = .lightGray
            button.titleLabel?.font = UIFont(name: "Helvetica", size: 18)
            
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0, y: button.frame.height + 5, width: button.frame.width, height: 1.0)
            bottomLine.backgroundColor = backgroundColorForObjects.cgColor
            button.layer.addSublayer(bottomLine)

            self.view.addSubview(button)
            startY += 50
        }
    }
}

