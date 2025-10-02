//
//  AddDetailsConfigurator.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//


import Foundation

protocol AddDetailsConfigurator {
    func configure(viewController: AddDetailsView, bookSource: BookSource)
}

final class AddDetailsConfiguratorImplementation: AddDetailsConfigurator {
    func configure(viewController: AddDetailsView, bookSource: BookSource) {
        let dbGateway = CoreDataBooksDatabaseGateway()
        let networkGateway = NetworkBookDetailsGateway()
        
        let generateDescUseCase = GenerateBookDescriptionUseCaseImplementation(gateway: networkGateway)
        let saveBookUseCase = SaveBookUseCaseImplementation(dbGateway: dbGateway, networkGateway: networkGateway)
        
        let router = AddDetailsRouterImplementation(viewController: viewController)
        
        let presenter = AddDetailsPresenter(
            view: viewController,
            router: router,
            generateDescUseCase: generateDescUseCase,
            saveBookUseCase: saveBookUseCase,
            bookSource: bookSource
        )
        
        viewController.presenter = presenter
    }
}
