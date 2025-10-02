//
//  UserGateway.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

protocol MainUserGateway {
    func save(name: String)
    func getName() -> String? 
}

final class MainUserDefaultsUserGateway: MainUserGateway {
    private let userDefaults: UserDefaults
    private let nameKey = "name"

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func save(name: String) {
        userDefaults.set(name, forKey: nameKey)
    }
    
    func getName() -> String? {
        return userDefaults.string(forKey: nameKey)
    }
}
