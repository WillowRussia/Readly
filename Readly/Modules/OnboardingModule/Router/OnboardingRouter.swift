//
//  OnboardingRouter.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import UIKit

protocol OnboardingRouter {
    func navigateToMainApp()
}

final class OnboardingRouterImplementation: OnboardingRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToMainApp() {
        guard let window = viewController?.view.window else { return }
        
        let mainView = MainView()
        let configurator = MainConfiguratorImplementation()
        configurator.configure(viewController: mainView)
        
        let rootNC = UINavigationController(rootViewController: mainView)
        
        window.rootViewController = rootNC
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
}
