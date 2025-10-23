//
//  UserGateway.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

protocol UserGateway {
    func save(name: String)
}

final class UserDefaultsUserGateway: UserGateway {
    private let userDefaults: UserDefaults
    private let nameKey = "name"

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func save(name: String) {
        userDefaults.set(name, forKey: nameKey)
    }
}