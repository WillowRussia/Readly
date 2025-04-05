//
//  MainPresenter.swift
//  Readly
//
//  Created by Илья Востров on 09.03.2025.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var name: String { get }
}

class MainPresenter: MainPresenterProtocol {
    
    var name: String
    
    weak var view: (any MainViewProtocol)?
    
    init(view: any MainViewProtocol) {
        self.view = view
        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
    }
    
}
