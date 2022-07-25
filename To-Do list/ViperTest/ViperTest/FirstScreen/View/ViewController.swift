//
//  ViewController.swift
//  ViperTest
//
//  Created by Владимир Осипов on 25.07.2022.
//

import UIKit

class ViewController: UIViewController, ViewInput {
    
    @IBOutlet weak var label: UILabel!
    var output: ViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showFormattedString(_ string: String) {
        label.text = string
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        output.buttonAction()
    }
}
