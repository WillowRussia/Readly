//
//  RegistPresenter.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import UIKit

protocol RegistPresenterProtocol: AnyObject {
    func checkName(name: String)
}

class RegistPresenter: RegistPresenterProtocol {
    
    weak var view: (any RegistViewProtocol)?
    
    init(view: any RegistViewProtocol){
        self.view = view
    }
    
    func checkName(name: String) {
        if name.count >= 2 {
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(WindowCase.onboarding.rawValue, forKey: "state")
            NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: WindowCase.onboarding])
        } else {
            view?.showAlert(title: "Ошибка", message: "Имя должно содержать минимум 2 символа")
        }
    }
    
}
