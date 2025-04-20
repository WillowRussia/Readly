//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

protocol AddDetailsPresenterProtocol: AnyObject {
    
}

class AddDetailsPresenter: AddDetailsPresenterProtocol {
    
    weak var view: (any AddDetailsViewProtocol)?
    
    init(view: any AddDetailsViewProtocol){
        self.view = view
    }
    
}
