import UIKit
import SnapKit

class ProductPageViewController: UIViewController {
    var product: Product?
    let (backButton, shareButton, favoriteButton, grayRoundButton, brownRoundButton) = (UIButton(), UIButton(), UIButton(), UIButton(), UIButton())
    let addToCartButton = UIButton(type: .system)
    let (titleLabel, pricelabel, titleBottomLabel) = (UILabel(), UILabel(), UILabel())
    let scrollView = UIScrollView()
    var stackView = UIStackView()
    let tintColorForButtons = UIColor(red: 0.37, green: 0.78, blue: 0.9, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBarButtonitems()
        createTitleLabel()
        createTitleBottomLabel()
        createPriceLabel()
        createScrollView()
        createRoundButtons()
        createAddToCartButton()
        makeConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        grayRoundButton.layer.cornerRadius = grayRoundButton.bounds.size.height / 2
        brownRoundButton.layer.cornerRadius = brownRoundButton.bounds.size.width / 2
    }
    
    //создаем кастомные кнопки сверху
    func createBarButtonitems() {
        backButton.setTitle(" Поиск", for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFill
        backButton.setTitleColor(tintColorForButtons, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        setTintColorAndImageForBarButton(systemName: "chevron.left", for: backButton)
        setTintColorAndImageForBarButton(systemName: "square.and.arrow.up", for: shareButton)
        setTintColorAndImageForBarButton(systemName: "heart", for: favoriteButton)
        let leftBarButton = UIBarButtonItem(customView: backButton)
        let rightShareBarButton = UIBarButtonItem(customView: shareButton)
        let rightFavoriteBarButton = UIBarButtonItem(customView: favoriteButton)
        let fixedSpace = UIBarButtonItem(systemItem: .fixedSpace, primaryAction: nil, menu: nil)
        fixedSpace.width = 20
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItems = [rightFavoriteBarButton, fixedSpace, rightShareBarButton]
    }
    //переходим назад
    @objc func goBack(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    //верстка лейблов
    func createTitleLabel(){
        titleLabel.text = product?.description
        setGeneralOptionsForLabels(label: titleLabel, font: "Helvetica-Bold", size: 17, color: .white)
    }
    func createPriceLabel(){
        pricelabel.text = "\(product!.price) .00 руб"
        setGeneralOptionsForLabels(label: pricelabel, font: "Helvetica-Bold", size: 17, color: .lightGray)
    }
    func createTitleBottomLabel(){
        titleBottomLabel.text = product?.description
        setGeneralOptionsForLabels(label: titleBottomLabel, font: "Helvetica", size: 12, color: .lightGray)
    }
    
    //верстка ScrollView
    func createScrollView(){
        var startXForView = 0
        scrollView.backgroundColor = .white
        scrollView.frame = CGRect(x: 20, y: 192, width: view.bounds.width, height: 213)
//        scrollView.contentSize = CGSize(width: (view.bounds.width * CGFloat((model.productPhoto[keyValue]?.count)!)),
//                                        height: scrollView.bounds.height)
        //добавляем фото из словаря соответствующего ключа
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
        //стиль прокрутки
        scrollView.isPagingEnabled = true
        //белые индикаторы
        scrollView.indicatorStyle = .white
        
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(tapForViewAction(_:)))
        scrollView.addGestureRecognizer(recognizer)
        
        view.addSubview(scrollView)
    }
    @objc func tapForViewAction(_ gestureRecognizer: UITapGestureRecognizer) {
        //переходим на следующий экран
//        let webBrowser = WebPageViewController()
//        webBrowser.viewTag = self.viewTag
//        self.navigationController?.pushViewController(webBrowser, animated: true)
    }
    //верстка круглых кнопок
    func createRoundButtons(){
        grayRoundButton.backgroundColor = .lightGray
        brownRoundButton.backgroundColor = .brown

        print(brownRoundButton.bounds.size.width)
        stackView = UIStackView(arrangedSubviews: [grayRoundButton, brownRoundButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 20
        view.addSubview(stackView)

    }
    //кнопка Добавить в корзину
    func createAddToCartButton(){
        addToCartButton.setTitle("Добавить в корзину", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.backgroundColor = tintColorForButtons
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        view.addSubview(addToCartButton)
    }
    
    
    //MARK: Вспомогательные функции
    //создаём лейблы
    func setGeneralOptionsForLabels(label: UILabel, font: String, size: CGFloat, color: UIColor){
        //label.frame = CGRect(x: 0, y: frameY, width: Int(view.bounds.width), height: 21)
        label.font = UIFont(name: font, size: size)
        label.textColor = color
        label.textAlignment = .center
        view.addSubview(label)
    }
    //картинка и цвет для кнопок сверху
    func setTintColorAndImageForBarButton(systemName: String, for button: UIButton){
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.imageView?.tintColor = tintColorForButtons
    }
}

//MARK: Констрейнты
extension ProductPageViewController{
    private func makeConstraints(){
        addToCartButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        pricelabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel).inset(50)
        }
        stackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
}
