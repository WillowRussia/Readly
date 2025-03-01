//
//  RegistPresenter.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

protocol RegistPresenterProtocol: AnyObject {}

class RegistPresenter: RegistPresenterProtocol {
    weak var view: (any RegistViewProtocol)?
    
    init(view: any RegistViewProtocol){
        self.view = view
    }
    
}
