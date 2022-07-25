//
//  Router.swift
//  ViperTest
//
//  Created by Владимир Осипов on 25.07.2022.
//

import Foundation
import UIKit

class Router: RouterInput{
    
    weak var view: UIViewController!
    
    func showOkAlert(){
        let alert = UIAlertController(title: "Hi", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okButton)
        view.present(alert, animated: true, completion: nil)
    }
}
