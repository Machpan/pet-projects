//
//  Assembly.swift
//  ViperTest
//
//  Created by Владимир Осипов on 25.07.2022.
//

import Foundation
import UIKit

class Assembly: NSObject{
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        guard let view = viewController as? ViewController else { return }
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()
        let dataManager = DataManagerImplementation()
        
        view.output = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.dataManager = dataManager
        interactor.output = presenter
        
        router.view = view
    }
}
