//
//  MainConfigurator.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

protocol MainConfigurator {
    func configure(viewController: MainView)
}

final class MainConfiguratorImplementation: MainConfigurator {
    func configure(viewController: MainView) {
        let userGateway = MainUserDefaultsUserGateway()
        let booksGateway = BookGatewayImplementation()
        
        let useCase = FetchMainScreenDataUseCaseImplementation(userGateway: userGateway, booksGateway: booksGateway)
        
        let router = MainRouterImplementation(viewController: viewController)
        
        let presenter = MainPresenter(view: viewController, useCase: useCase, router: router)
        
        viewController.presenter = presenter
    }
}
