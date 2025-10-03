//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import Foundation

protocol BookListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectBook(_ book: JsonBookModelItem)
    func didTapBack()
}

final class BookListPresenter: BookListPresenterProtocol {
    
    private weak var view: BookListViewProtocol?
    private let router: BookListRouter
    
    let bookList: [JsonBookModelItem]
    let bookTitle: String
    
    init(
        view: BookListViewProtocol,
        router: BookListRouter,
        bookList: [JsonBookModelItem],
        bookTitle: String
    ) {
        self.view = view
        self.router = router
        self.bookList = bookList
        self.bookTitle = bookTitle
    }
    
    func viewDidLoad() {
        view?.display(books: self.bookList, title: self.bookTitle)
    }
    
    func didSelectBook(_ book: JsonBookModelItem) {
        router.navigateToDetails(for: book)
    }
    
    func didTapBack() {
        router.close()
    }
}
