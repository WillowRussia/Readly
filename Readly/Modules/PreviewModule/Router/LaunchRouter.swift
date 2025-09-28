//
//  LaunchRouter.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import UIKit

protocol LaunchRouter {
    func navigateToNextScreen()
}

final class LaunchRouterImplementation: LaunchRouter {
    private let window: UIWindow
    private let windowStateGateway: WindowStateGateway
    
    init(window: UIWindow, windowStateGateway: WindowStateGateway) {
        self.window = window
        self.windowStateGateway = windowStateGateway
    }
    
    func navigateToNextScreen() {
        let state = windowStateGateway.getWindowState()
        
        let nextViewController: UIViewController
        
        switch state {
        case .regist:
            let registView = Builder.createRegistView()
//            let registView = RegistView()
//            let configurator = RegistConfiguratorImplementation()
//            configurator.configure(viewController: registView)
            nextViewController = registView
            
        case .onboarding:
            let onboardingView = Builder.createOnboardingView()
//            let onboardingView = OnboardingView()
//            let configurator = OnboardingConfiguratorImplementation()
//            configurator.configure(viewController: onboardingView)
            nextViewController = onboardingView
            
        case .main:
            let mainView = Builder.createMainView()
//            let mainView = MainView()
//            let configurator = MainConfiguratorImplementation()
//            configurator.configure(viewController: mainView)
//            nextViewController = UINavigationController(rootViewController: mainView)
            nextViewController = mainView
        }
        
        window.rootViewController = nextViewController
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
