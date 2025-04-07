//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

protocol DetailsPresenterProtocol: AnyObject {
    
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: (any DetailsViewProtocol)?
    
    init(view: any DetailsViewProtocol){
        self.view = view
    }
    
}
