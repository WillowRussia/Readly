//
//  MainRouter.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import UIKit

protocol MainRouter {
    func navigateToDetails(for book: Book)
    func navigateToAddBook()
}

final class MainRouterImplementation: MainRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToDetails(for book: Book) {
        let detailsView = DetailsView()
        let configurator = DetailsConfiguratorImplementation()
        configurator.configure(viewController: detailsView, book: book)
        
        viewController?.navigationController?.pushViewController(detailsView, animated: true)
    }
    
    func navigateToAddBook() {
        let addBookView = AddBookView()
        let configurator = AddBookConfiguratorImplementation()
        configurator.configure(viewController: addBookView)
        
        viewController?.navigationController?.pushViewController(addBookView, animated: true)
    }
}
