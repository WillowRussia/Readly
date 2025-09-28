//
//  RegistConfigurator.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

protocol RegistConfigurator {
    func configure(viewController: RegistView)
}

final class RegistConfiguratorImplementation: RegistConfigurator {
    func configure(viewController: RegistView) {
        let userGateway = UserDefaultsUserGateway()
        let windowStateGateway = UserDefaultsWindowStateGateway()
        
        let useCase = RegistUseCaseImplementation(userGateway: userGateway, windowStateGateway: windowStateGateway)
        
        let router = RegistRouterImplementation(viewController: viewController)
        
        let presenter = RegistPresenter(view: viewController, useCase: useCase, router: router)
        
        viewController.presenter = presenter
    }
}
