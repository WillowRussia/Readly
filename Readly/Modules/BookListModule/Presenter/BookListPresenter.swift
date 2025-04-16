//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

protocol BookListPresenterProtocol: AnyObject {
    
}

class BookListPresenter: BookListPresenterProtocol {
    
    weak var view: (any BookListViewProtocol)?
    
    init(view: any BookListViewProtocol){
        self.view = view
    }
    
}
