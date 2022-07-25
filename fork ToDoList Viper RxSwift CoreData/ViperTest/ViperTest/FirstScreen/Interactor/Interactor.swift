//
//  Interactor.swift
//  ViperTest
//
//  Created by Владимир Осипов on 25.07.2022.
//

import Foundation

class Interactor: InteractorInput{
    
    weak var output: InteractorOutput!
    var dataManager: DataManager!
    
    func obtainFormattedString() {
        let numbers = dataManager.obtainNumbers()
        let numbersString = numbers.map({ "\($0)" }).joined(separator: ", ")
        output.didFinishObtainingFormattedString(numbersString)
    }
    
    
}
