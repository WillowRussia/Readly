//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

protocol DetailsPresenterProtocol: AnyObject {
    var book: Book { get set }
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: (any DetailsViewProtocol)?
    var book: Book
    
    init(view: any DetailsViewProtocol, book: Book){
        self.view = view
        self.book = book
    }
    
}
