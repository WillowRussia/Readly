//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import Foundation

protocol AddBookPresenterProtocol: AnyObject {
    func searchBooks(by title: String)
    func didTapCloseButton()
}

final class AddBookPresenter: AddBookPresenterProtocol {
    private weak var view: AddBookViewProtocol?
    private let searchUseCase: SearchBooksUseCase
    private let router: AddBookRouter
    
    init(view: AddBookViewProtocol, searchUseCase: SearchBooksUseCase, router: AddBookRouter) {
        self.view = view
        self.searchUseCase = searchUseCase
        self.router = router
    }
    
    func searchBooks(by title: String) {
        view?.showLoading(true)
        let parameters = SearchBookParameters(title: title)
        
        searchUseCase.search(parameters: parameters) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.view?.showLoading(false)
                switch result {
                case .success(let books):
                    self.router.navigateToBookList(books: books, title: title)
                case .failure(let error):
                    self.view?.showAlert(title: "Ошибка", message: error.localizedDescription)
                }
            }
        }
    }
    
    func didTapCloseButton() {
        router.close()
    }
}
