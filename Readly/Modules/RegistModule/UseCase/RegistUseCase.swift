//
//  RegistrationError.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

enum RegistrationError: Error, LocalizedError {
    case nameTooShort
    
    var errorDescription: String? {
        switch self {
        case .nameTooShort:
            return "Имя должно содержать минимум 2 символа"
        }
    }
}

protocol RegistUseCase {
    func register(name: String, completion: @escaping (EmptyResult) -> Void)
}

final class RegistUseCaseImplementation: RegistUseCase {
    private let userGateway: UserGateway
    private let windowStateGateway: WindowStateGateway
    
    init(userGateway: UserGateway, windowStateGateway: WindowStateGateway) {
        self.userGateway = userGateway
        self.windowStateGateway = windowStateGateway
    }
    
    func register(name: String, completion: @escaping (EmptyResult) -> Void) {
        guard name.count >= 2 else {
            completion(.failure(RegistrationError.nameTooShort))
            return
        }
        
        userGateway.save(name: name)
        windowStateGateway.save(windowState: .onboarding)
        
        completion(.success(()))
    }
}
