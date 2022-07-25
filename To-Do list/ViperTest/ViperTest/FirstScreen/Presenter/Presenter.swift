//
//  Presenter.swift
//  ViperTest
//
//  Created by Владимир Осипов on 25.07.2022.
//

import Foundation

class Presenter: ViewOutput, InteractorOutput{

    weak var view: ViewInput!
    var interactor: InteractorInput!
    var router: RouterInput!
    //ViewOutput
    func buttonAction() {
        interactor.obtainFormattedString()
    }
    //InteractorOutput
    func didFinishObtainingFormattedString(_ string: String) {
        view.showFormattedString(string)
        router.showOkAlert()
    }
}
