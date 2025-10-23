//
//  MainPresenter.swift
//  Readly
//
//  Created by Илья Востров on 09.03.2025.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewWillAppear()
    func didSelect(book: Book)
    func didTapAddBook()
}

final class MainPresenter: MainPresenterProtocol {
    private weak var view: MainViewProtocol?
    private let useCase: FetchMainScreenDataUseCase
    private let router: MainRouter
    
    init(view: MainViewProtocol, useCase: FetchMainScreenDataUseCase, router: MainRouter) {
        self.view = view
        self.useCase = useCase
        self.router = router
    }
    
    func viewWillAppear() {
        let data = useCase.execute()
        
        let viewModel = MainViewModel(userName: data.userName, booksByStatus: data.booksByStatus)
        
        view?.display(viewModel: viewModel)
    }
    
    func didSelect(book: Book) {
        router.navigateToDetails(for: book)
    }
    
    func didTapAddBook() {
        router.navigateToAddBook()
    }
}
