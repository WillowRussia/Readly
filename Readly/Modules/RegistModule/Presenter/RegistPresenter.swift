//
//  RegistPresenter.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import Foundation

protocol RegistPresenterProtocol: AnyObject {
    func registerButtonPressed(name: String)
}

final class RegistPresenter: RegistPresenterProtocol {
    private weak var view: RegistViewProtocol?
    private let useCase: RegistUseCase
    private let router: RegistRouter
    
    init(view: RegistViewProtocol, useCase: RegistUseCase, router: RegistRouter) {
        self.view = view
        self.useCase = useCase
        self.router = router
    }
    
    func registerButtonPressed(name: String) {
        
        useCase.register(name: name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.router.navigateToOnboarding()
            case .failure(let error):
                self.view?.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }
}
