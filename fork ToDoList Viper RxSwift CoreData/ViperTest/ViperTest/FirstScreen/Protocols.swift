//
//  Protocols.swift
//  ViperTest
//
//  Created by Владимир Осипов on 25.07.2022.
//

import Foundation

protocol DataManager{
    func obtainNumbers() -> [Int]
}
protocol RouterInput: AnyObject{
    func showOkAlert()
}
protocol InteractorInput: AnyObject{
    func obtainFormattedString()
}
protocol InteractorOutput: AnyObject{
    func didFinishObtainingFormattedString(_ string: String)
}
protocol ViewInput: AnyObject{
    func showFormattedString(_ string: String)
}
protocol ViewOutput: AnyObject{
    func buttonAction()
}
