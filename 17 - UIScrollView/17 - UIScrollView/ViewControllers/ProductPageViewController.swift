import UIKit

class ProductPageViewController: UIViewController {
//    
//    let (backButton, shareButton, favoriteButton, grayRoundButton, brownRoundButton, addToCartButton) = (UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton())
//    let (titleLabel, pricelabel, titleBottomLabel) = (UILabel(), UILabel(), UILabel())
//    let scrollView = UIScrollView()
//    var productTitleLabelValue = ""
//    var priceLabelValue = ""
//    var viewTag = 0
//    let tintColorForButtons = UIColor(red: 0.37, green: 0.78, blue: 0.9, alpha: 1)
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        createBarButtonitems()
//        createTitleLabel()
//        createTitleBottomLabel()
//        createPriceLabel()
//        createScrollView()
//        createRoundButtons()
//        createAddToCartButton()
//    }
//    //создаем кастомные кнопки сверху
//    func createBarButtonitems() {
//        backButton.setTitle(" Поиск", for: .normal)
//        backButton.imageView?.contentMode = .scaleAspectFill
//        backButton.setTitleColor(tintColorForButtons, for: .normal)
//        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
//        setTintColorAndImageForBarButton(systemName: "chevron.left", for: backButton)
//        
//        setTintColorAndImageForBarButton(systemName: "square.and.arrow.up", for: shareButton)
//        setTintColorAndImageForBarButton(systemName: "heart", for: favoriteButton)
//        
//        let leftBarButton = UIBarButtonItem(customView: backButton)
//        let rightShareBarButton = UIBarButtonItem(customView: shareButton)
//        let rightFavoriteBarButton = UIBarButtonItem(customView: favoriteButton)
//        
//        self.navigationItem.leftBarButtonItem = leftBarButton
//        self.navigationItem.rightBarButtonItems = [rightFavoriteBarButton, rightShareBarButton]
//        
//    }
//    //переходим назад
//    @objc func goBack(){
//        self.navigationController?.popToRootViewController(animated: true)
//    }
//    //верстка лейблов
//    func createTitleLabel(){
//        titleLabel.text = productTitleLabelValue
//        setGeneralOptionsForLabels(label: titleLabel, frameY: 100, font: "Helvetica-Bold", size: 17, color: .white)
//    }
//    func createPriceLabel(){
//        pricelabel.text = priceLabelValue + ".00 руб"
//        setGeneralOptionsForLabels(label: pricelabel, frameY: 130, font: "Helvetica-Bold", size: 17, color: .lightGray)
//    }
//    func createTitleBottomLabel(){
//        titleBottomLabel.text = productTitleLabelValue
//        setGeneralOptionsForLabels(label: titleBottomLabel, frameY: 438, font: "Helvetica", size: 12, color: .lightGray)
//    }
//    //верстка ScrollView
//    func createScrollView(){
//        var startXForView = 0
//        //проверяем переданный тег Вью и меняем ключ для доступа к словарю, где хранятся фотки товара
//        var keyValue = ""
//        switch viewTag{
//        case 0: keyValue = "iphone"
//        case 1: keyValue = "macbook"
//        case 2: keyValue = "iwatch"
//        case 3: keyValue = "ipad"
//        default: break
//        }
//        scrollView.frame = CGRect(x: 20, y: 192, width: view.bounds.width, height: 213)
//        scrollView.contentSize = CGSize(width: (view.bounds.width * CGFloat((model.productPhoto[keyValue]?.count)!)),
//                                        height: scrollView.bounds.height)
//        //добавляем фото из словаря соответствующего ключа
//        if let photoBank = model.productPhoto[keyValue]{
//            for onePhoto in photoBank{
//                let imageView = UIImageView()
//                imageView.frame = CGRect(x: startXForView, y: 0, width: Int(view.bounds.width), height: 213)
//                imageView.contentMode = .scaleAspectFit
//                imageView.image = onePhoto
//                scrollView.addSubview(imageView)
//                startXForView += Int(imageView.bounds.width)
//            }
//        }
//        //стиль прокрутки
//        scrollView.isPagingEnabled = true
//        //белые индикаторы
//        scrollView.indicatorStyle = .white
//        
//        let recognizer = UITapGestureRecognizer()
//        recognizer.addTarget(self, action: #selector(tapForViewAction(_:)))
//        scrollView.addGestureRecognizer(recognizer)
//        
//        view.addSubview(scrollView)
//    }
//    @objc func tapForViewAction(_ gestureRecognizer: UITapGestureRecognizer) {
//        //переходим на следующий экран
//        let webBrowser = WebPageViewController()
//        webBrowser.viewTag = self.viewTag
//        self.navigationController?.pushViewController(webBrowser, animated: true)
//    }
//    //верстка круглых кнопок
//    func createRoundButtons(){
//        grayRoundButton.backgroundColor = .lightGray
//        brownRoundButton.backgroundColor = .brown
//        let buttonsArray = [grayRoundButton, brownRoundButton]
//        var startX = 140
//        for oneButton in buttonsArray{
//            oneButton.frame = CGRect(x: startX, y: 515, width: 50, height: 50)
//            oneButton.layer.cornerRadius = oneButton.bounds.width / 2
//            view.addSubview(oneButton)
//            startX += 70
//        }
//    }
//    //кнопка Добавить в корзину
//    func createAddToCartButton(){
//        addToCartButton.setTitle("Добавить в корзину", for: .normal)
//        addToCartButton.frame = CGRect(x: 20, y: 675, width: 374, height: 50)
//        addToCartButton.setTitleColor(.white, for: .normal)
//        addToCartButton.backgroundColor = model.tintColorForButtons
//        addToCartButton.layer.cornerRadius = 10
//        addToCartButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
//        view.addSubview(addToCartButton)
//    }
//    //MARK: Вспомогательные функции
//    //создаём лейблы
//    func setGeneralOptionsForLabels(label: UILabel, frameY: Int, font: String, size: CGFloat, color: UIColor){
//        label.frame = CGRect(x: 0, y: frameY, width: Int(view.bounds.width), height: 21)
//        label.font = UIFont(name: font, size: size)
//        label.textColor = color
//        label.textAlignment = .center
//        view.addSubview(label)
//    }
//    //картинка и цвет для кнопок сверху
//    func setTintColorAndImageForBarButton(systemName: String, for button: UIButton){
//        button.setImage(UIImage(systemName: systemName), for: .normal)
//        button.imageView?.tintColor = model.tintColorForButtons
//    }
}
