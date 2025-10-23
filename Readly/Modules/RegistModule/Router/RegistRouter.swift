//
//  RegistRouter.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import UIKit

protocol RegistRouter {
    func navigateToOnboarding()
}

final class RegistRouterImplementation: RegistRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToOnboarding() {
        guard let window = viewController?.view.window else { return }
        
        let onboardingView = OnboardingView()
        let configurator = OnboardingConfiguratorImplementation()
        configurator.configure(viewController: onboardingView)
        
        window.rootViewController = onboardingView
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
}
