//
//  DetailsRouter.swift
//  Readly
//
//  Created by Илья Востров on 03.10.2025.
//

import UIKit

protocol DetailsRouter {
    func close()
    func navigateToEdit(book: Book)
}

final class DetailsRouterImplementation: DetailsRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func close() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToEdit(book: Book) {
        let addDetailsVC = AddDetailsView()
        let configurator = AddDetailsConfiguratorImplementation()
        configurator.configure(viewController: addDetailsVC, bookSource: .coreData(book))
        
        viewController?.navigationController?.pushViewController(addDetailsVC, animated: true)
    }
}
