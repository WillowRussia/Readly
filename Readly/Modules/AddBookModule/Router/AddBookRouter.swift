//
//  AddBookViewRouter.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//

import UIKit

protocol AddBookRouter: AnyObject {
    func navigateToBookList(books: [JsonBookModelItem], title: String)
    func close()
}

final class AddBookRouterImplementation: AddBookRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToBookList(books: [JsonBookModelItem], title: String) {
        let bookListView = BookListView()
        let configurator = BookListConfiguratorImplementation()
        configurator.configure(
            viewController: bookListView,
            bookList: books,
            bookTitle: title
        )
        viewController?.navigationController?.pushViewController(bookListView, animated: true)
    }
    
    // Реализация нового метода
    func close() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
