//
//  AddBookConfigurator.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//


import Foundation

protocol AddBookConfigurator {
    func configure(viewController: AddBookView)
}

final class AddBookConfiguratorImplementation: AddBookConfigurator {
    func configure(viewController: AddBookView) {
        let router = AddBookRouterImplementation(viewController: viewController)
        
        let networkManager = BookNetworkManager.shared
        let gateway = ApiBooksGatewayImplementation(networkManager: networkManager)
        let useCase = SearchBooksUseCaseImplementation(booksGateway: gateway)
        
        let presenter = AddBookPresenter(
            view: viewController,
            searchUseCase: useCase,
            router: router
        )
        
        viewController.presenter = presenter
    }
}
