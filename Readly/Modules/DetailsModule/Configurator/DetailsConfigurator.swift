//
//  DetailsConfigurator.swift
//  Readly
//
//  Created by Илья Востров on 03.10.2025.
//

import Foundation

protocol DetailsConfigurator {
    func configure(viewController: DetailsView, book: Book)
}

final class DetailsConfiguratorImplementation: DetailsConfigurator {
    
    func configure(viewController: DetailsView, book: Book) {
        let router = DetailsRouterImplementation(viewController: viewController)
        
        let fetchDetailsUC = FetchBookDetailsUseCaseImplementation()
        let manageNotesUC = ManageNotesUseCaseImplementation()
        let updateStatusUC = UpdateBookStatusUseCaseImplementation()
        let deleteBookUC = DeleteBookUseCaseImplementation()
        
        let presenter = DetailsPresenter(
            view: viewController,
            router: router,
            book: book,
            fetchDetailsUC: fetchDetailsUC,
            manageNotesUC: manageNotesUC,
            updateStatusUC: updateStatusUC,
            deleteBookUC: deleteBookUC
        )
        
        viewController.presenter = presenter
    }
}
