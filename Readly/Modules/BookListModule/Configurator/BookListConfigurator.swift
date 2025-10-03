//
//  BookListConfigurator.swift
//  Readly
//
//  Created by Илья Востров on 03.10.2025.
//

import Foundation

protocol BookListConfigurator {
    func configure(
        viewController: BookListView,
        bookList: [JsonBookModelItem],
        title: String
    )
}

final class BookListConfiguratorImplementation: BookListConfigurator {
    
    func configure(
        viewController: BookListView,
        bookList: [JsonBookModelItem],
        title: String
    ) {
        let router = BookListRouterImplementation(viewController: viewController)
        
        let presenter = BookListPresenter(
            view: viewController,
            router: router,
            bookList: bookList,
            bookTitle: title
        )
        
        viewController.presenter = presenter
    }
}
