import UIKit

class SearchViewController: UIViewController {
    let (searchLabel, recentlyWatchedLabel, requestslabel) = (UILabel(), UILabel(), UILabel())
    let searchTextField = UITextField()
    let scrollView = UIScrollView()
    
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
        searchTextField.backgroundColor = model.backgroundColorForObjects
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
        scrollView.frame = CGRect(x: 20, y: 303, width: 374, height: 175)
        //размер соответствует фрейму * количество товара в базе + 10px между товаром
        scrollView.contentSize = CGSize(width: (recentlyViewFrame.width * CGFloat(model.recentlyWatched.count)) + CGFloat((model.recentlyWatched.count * 10)),
                                        height: recentlyViewFrame.height)
        //пробегаемся в цикле по базе товаров с индексом
        for (tag, base) in model.recentlyWatched.enumerated(){
            let viewForOneObject = UIView()
            let imageView = UIImageView()
            let label = UILabel()
            //верстаем вью
            viewForOneObject.backgroundColor = model.backgroundColorForObjects
            viewForOneObject.layer.cornerRadius = 10
            viewForOneObject.frame = CGRect(x: startXForView, y: 0, width: 128, height: 162)
            //верстаем imageView
            imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 100)
            imageView.contentMode = .scaleAspectFit
            imageView.image = base.image
            //верстаем лейбл
            label.frame = CGRect(x: 8, y: 110, width: 112, height: 45)
            //текст берем из модели
            label.text = base.descriptionText
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
            scrollView.addSubview(viewForOneObject)
            //перемещаем координату Х для следующего вью
            startXForView += Int(viewForOneObject.bounds.width) + 10
        }
        view.addSubview(scrollView)
    }
    //тап по пью
    @objc func tapForViewAction(_ gestureRecognizer: UITapGestureRecognizer) {
        //запоминаем индекс вью
        let productIndex = gestureRecognizer.view?.tag
        //переходим на следующий экран
        let productPage = ProductPageViewController()
        //кидаем туда картинки, стоимость товара и описание товара
        productPage.productTitleLabelValue = model.recentlyWatched[productIndex ?? 0].descriptionText
        productPage.priceLabelValue = String(model.price[productIndex ?? 0])
        productPage.viewTag = productIndex ?? 0
        
        self.navigationController?.pushViewController(productPage, animated: true)
    }
        
    //верстка кнопок Варианты запросов
    func createQueryOptionsButtons(){
        var startY = 550
        for query in model.queryOptions{
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
            bottomLine.backgroundColor = model.backgroundColorForObjects.cgColor
            button.layer.addSublayer(bottomLine)

            self.view.addSubview(button)
            startY += 50
        }
    }
}

