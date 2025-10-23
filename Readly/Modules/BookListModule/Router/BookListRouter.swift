//
//  BookListRouter.swift
//  Readly
//
//  Created by Илья Востров on 03.10.2025.
//

import UIKit

protocol BookListRouter {
    func navigateToDetails(for book: JsonBookModelItem)
    func close()
}

final class BookListRouterImplementation: BookListRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToDetails(for book: JsonBookModelItem) {
        let addDetailsVC = AddDetailsView()
        let configurator = AddDetailsConfiguratorImplementation()
        configurator.configure(viewController: addDetailsVC, bookSource: .json(book))
        
        viewController?.navigationController?.pushViewController(addDetailsVC, animated: true)
    }
    
    func close() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
