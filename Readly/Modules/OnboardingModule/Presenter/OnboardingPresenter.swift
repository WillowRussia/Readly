//
//  OnboardingViewPresenter.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    var mockData: [OnboardinData] { get }
    func startApp()
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    
    var mockData: [OnboardinData] = OnboardinData.mockData
    
    weak var view: (any OnboardingViewProtocol)?
    
    init(view: any OnboardingViewProtocol){
        self.view = view
    }
    
    func startApp() {
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: WindowCase.main])
    }
    
}
