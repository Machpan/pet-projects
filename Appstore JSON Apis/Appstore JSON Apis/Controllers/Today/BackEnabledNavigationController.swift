//
//  BackEnabledNavigationController.swift
//  Appstore JSON Apis
//
//  Created by Владимир Осипов on 21.08.2022.
//

import UIKit

class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        self.viewControllers.count > 1
    }
}
