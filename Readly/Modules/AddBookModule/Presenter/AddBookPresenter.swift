//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

protocol AddBookPresenterProtocol: AnyObject {
    
}

class AddBookPresenter: AddBookPresenterProtocol {
    
    weak var view: (any AddBookViewProtocol)?
    
    init(view: any AddBookViewProtocol){
        self.view = view
    }
    
}
