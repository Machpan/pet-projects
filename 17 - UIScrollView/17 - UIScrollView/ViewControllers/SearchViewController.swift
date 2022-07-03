import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let (searchLabel, recentlyWatchedLabel, requestslabel) = (UILabel(), UILabel(), UILabel())
    private let searchTextField = UITextField()
    private var stackView = UIStackView()
    private let scrollView = UIScrollView()
    //добавляем объекты в модель
    public var recentlyWatchedObjects = [Product(price: 990, description: "Силиконовый чехол для iPhone 8-13", productPhoto: ["iphone" ,"1", "2", "3"], webPage: "pikabu.ru"),
                                  Product(price: 2300, description: "Чехол для MacBook Pro m1", productPhoto: ["macbook", "mb1", "mb2", "mb3"], webPage: "yandex.ru"),
                                  Product(price: 4800, description: "Кожаный ремешок для Apple Watch series", productPhoto: ["iwatch", "w1", "w2", "w3"], webPage: "mobile-review.com"),
                                  Product(price: 2400, description: "Противоударный чехол для iPad", productPhoto: ["ipad", "ipad1", "ipad2", "ipad3"], webPage: "rutube.com")]
    //тёмно-серый фон для объектов
    private let backgroundColorForObjects = UIColor(red: 0.07, green: 0.09, blue: 0.1, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTitleLabels(label: searchLabel, text: "Поиск", fontSize: 35)
        createTitleLabels(label: recentlyWatchedLabel, text: "Недавно просмотренные", fontSize: 22)
        createTitleLabels(label: requestslabel, text: "Варианты запросов", fontSize: 22)
        createSearchTextField()
        createQueryOptionsButtons()
        createScrollView()
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
    //верстка кнопок Варианты запросов
    private func createQueryOptionsButtons(){
        let queryOptions = ["AirPods", "AppleCare", "Beats", "Сравните модели iPhone"]
        var madeButtonsArray: [UIButton] = []
        for query in queryOptions{
            let button = UIButton()
            button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            button.setTitle(" " + query, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.contentHorizontalAlignment = .left
            button.imageView?.tintColor = .lightGray
            button.titleLabel?.font = UIFont(name: "Helvetica", size: 18)
            madeButtonsArray.append(button)
        }
        stackView = UIStackView(arrangedSubviews: madeButtonsArray)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 20
        view.addSubview(stackView)
    }
    //вёрстка ScrollView -> View -> ImageView + label
    private func createScrollView(){
        //начальная координата по оси Х для вью
        var startXForView = 0
        //фрейм для скроллВью
        let recentlyViewFrame = (width: 128, height: 162)
        //размер скролл вью соответствует фрейму * количество товара в модели + 10px между товаром
        scrollView.contentSize = CGSize(width: CGFloat(recentlyViewFrame.width * recentlyWatchedObjects.count + recentlyWatchedObjects.count * 10), height: CGFloat(recentlyViewFrame.height))
        //пробегаемся в цикле по базе товаров с индексом
        for (tag, base) in recentlyWatchedObjects.enumerated(){
            let viewForOneObject = UIView()
            let imageView = UIImageView()
            let label = UILabel()
            //верстаем вью
            viewForOneObject.backgroundColor = backgroundColorForObjects
            viewForOneObject.layer.cornerRadius = 10
            viewForOneObject.frame = CGRect(x: startXForView, y: 0, width: recentlyViewFrame.width, height: recentlyViewFrame.height)
            //верстаем imageView
            imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 100)
            imageView.contentMode = .scaleAspectFit
            //добавляем картинку из модели
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
            scrollView.addSubview(viewForOneObject)
            //перемещаем координату Х для следующего вью
            startXForView += Int(viewForOneObject.bounds.width) + 10
        }
        view.addSubview(scrollView)
    }
    //экшен для тапа по пью
    @objc private func tapForViewAction(_ gestureRecognizer: UITapGestureRecognizer) {
        //запоминаем индекс вью
        let productIndex = gestureRecognizer.view?.tag
        //переходим на следующий экран
        let productPage = ProductPageViewController()
        //кидаем туда картинки, стоимость товара и описание товара
        productPage.product = recentlyWatchedObjects[productIndex ?? 0]
        self.navigationController?.pushViewController(productPage, animated: true)
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
        requestslabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(250)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(requestslabel).inset(40)
            make.left.right.equalToSuperview().inset(16)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(recentlyWatchedLabel).inset(50)
            make.height.equalTo(175)
            make.left.right.equalToSuperview()
        }
    }
}
