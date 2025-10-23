//
//  WindowStateGateway.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

enum WindowCase: String {
    case regist, onboarding, main
}

protocol WindowStateGateway {
    func getWindowState() -> WindowCase
    func save(windowState: WindowCase)
}

final class UserDefaultsWindowStateGateway: WindowStateGateway {
    private let userDefaults: UserDefaults
    private let stateKey = "state"

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func getWindowState() -> WindowCase {
        if let stateRaw = userDefaults.string(forKey: stateKey),
           let state = WindowCase(rawValue: stateRaw) {
            return state
        }
        return .regist
    }
    
    func save(windowState: WindowCase) {
        userDefaults.set(windowState.rawValue, forKey: stateKey)
    }
}
