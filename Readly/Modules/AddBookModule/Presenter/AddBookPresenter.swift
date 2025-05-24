//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import Foundation

protocol AddBookPresenterProtocol: AnyObject {
    func searchBooks(by title: String)
}

class AddBookPresenter: AddBookPresenterProtocol {
    
    weak var view: (any AddBookViewProtocol)?
    private let manager = BookNetworkManager.shared
    
    init(view: any AddBookViewProtocol){
        self.view = view
    }
    
    func searchBooks(by title: String) {
        if title.count > 2 {
            manager.serachBookRequest(q: title) { [weak self] books in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch books {
                    case .success(let success):
                        self.view?.goToBookListView(bookList: success, bookTitle: title)
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            }
        } else {
            view?.showAlert(title: "Ошибка", message: "Имя книги должно содержать минимум 2 символа")
        }
    }
}
