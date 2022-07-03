//
//  WebPageViewController.swift
//  e-shop
//
//  Created by Владимир Осипов on 03.06.2022.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {
    var webPageValue = ""
    let webPage = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        webPage.frame = self.view.bounds
        self.view.addSubview(webPage)
        let stringForUrl = "https://www." + webPageValue
        if let url = URL(string: stringForUrl){
            let request = URLRequest(url: url)
            webPage.load(request)
            webPage.allowsBackForwardNavigationGestures = true
        }
    }
}
